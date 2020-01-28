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

    // MARK: - Public

    public init(theme: Theme = .default, handler: @escaping SelectionHandler) {
        let context = ImagePickerContext(theme: theme, selectionHanlder: handler)
        self.context = context

        let albumsController = AlbumsViewController(context: context)
        super.init(rootViewController: albumsController)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private
}
