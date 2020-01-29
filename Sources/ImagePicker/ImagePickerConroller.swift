//
//  ImagePickerController.swift
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import Photos
import UIKit

public class ImagePickerController: UINavigationController {
    // MARK: - Aliases

    public typealias SelectionHandler = (_ selectedAssets: [PHAsset]?) -> Void

    // MARK: - Instance variables

    private let context: ImagePickerContext
    private let presenter: ImagePickerPresetnerProtocol

    // MARK: - Public

    public init(theme: Theme = .default, handler: @escaping SelectionHandler) {
        let context = ImagePickerContext(theme: theme, selectionHanlder: handler)
        let presenter = ImagePickerPresetner()

        self.context = context
        self.presenter = presenter

        let albumsController = AlbumsViewController(
            context: context,
            presenter: presenter
        )
        super.init(rootViewController: albumsController)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private
}
