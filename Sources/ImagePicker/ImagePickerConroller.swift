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

    private lazy var doneButton = UIBarButtonItem(
        barButtonSystemItem: .done,
        target: self,
        action: #selector(onDoneTap)
    )

    // MARK: - Instance variables

    private let context: ImagePickerContext
    private let presenter: ImagePickerPresetnerProtocol

    // MARK: - Public

    public init(theme: Theme = .default, handler: @escaping SelectionHandler) {
        let context = ImagePickerContext(theme: theme)
        let presenter = ImagePickerPresetner(selectionHandler: handler)

        self.context = context
        self.presenter = presenter

        let albumsController = AlbumsViewController(
            context: context,
            presenter: presenter
        )
        super.init(rootViewController: albumsController)

        presenter.viewController = self
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupToolbar()
    }

    // MARK: - Private

    private func setupToolbar() {
        isToolbarHidden = false
    }

    @objc private func onDoneTap() {}
}
