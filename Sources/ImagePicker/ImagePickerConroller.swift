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
        albumsTitle: String = "Albums",
        handler: @escaping SelectionHandler
    ) {
        let context = ImagePickerContext(theme: theme)
        let presenter = ImagePickerPresetner(selectionHandler: handler)

        self.context = context
        self.presenter = presenter

        let albumsController = AlbumsViewController(
            context: context,
            presenter: presenter
        )
        albumsController.title = albumsTitle
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
        setupToolbar()
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
}
