//
//  ImagePickerController.swift
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import Photos
import UIKit

public class ImagePickerController: UINavigationController {
    // MARK: - Aliases

    public typealias SelectionHandler = (_ selectedAssets: [PHAsset]?) -> Void

    // MARK: - Widgets

    // MARK: - Instance variables

    private let context: ImagePickerContext
    private let presenter: ImagePickerPresetnerProtocol

    // MARK: - Public

    public init(
        theme: Theme = .default,
        config: Config = .default,
        handler: @escaping SelectionHandler
    ) {
        let context = ImagePickerContext(theme: theme, config: config)
        let presenter = ImagePickerPresetner(selectionHandler: handler)

        self.context = context
        self.presenter = presenter

        let albumsController = AlbumsViewController(
            context: context,
            presenter: presenter
        )
        albumsController.title = config.albumsTitle
        super.init(rootViewController: albumsController)

        presenter.viewController = self
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupToolbar()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pushRecentsAlbum()
    }

    // MARK: - Private

    private func setupToolbar() {
        isToolbarHidden = false
        toolbarItems = [
            CancelBarButtonView(presenter: presenter, theme: context.theme),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            DoneBarButtonView(presenter: presenter, theme: context.theme),
        ]
    }

    private func setupAppearance() {
        let navigationBarAppearance = UINavigationBar.appearance(
            whenContainedInInstancesOf: [ImagePickerController.self]
        )
        navigationBarAppearance.barStyle = .default
        navigationBarAppearance.isTranslucent = false
        navigationBarAppearance.tintColor = context.theme.color.accent
        navigationBarAppearance.titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 17),
        ]
    }

    private func pushRecentsAlbum() {
        let recentCollection = PHAssetCollection.fetchAssetCollections(
            with: .smartAlbum,
            subtype: .smartAlbumUserLibrary,
            options: nil
        )
        guard let album = recentCollection.firstObject else {
            return
        }
        let detailsController = AssetsGridViewController(
            context: context,
            album: album,
            presenter: presenter
        )
        pushViewController(detailsController, animated: false)
    }
}
