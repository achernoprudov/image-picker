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

    private let selectionHanlder: SelectionHandler

    // MARK: - Public

    public init(handler: @escaping SelectionHandler) {
        selectionHanlder = handler

        let albumsController = AlbumsViewController()
        super.init(rootViewController: albumsController)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private
}
