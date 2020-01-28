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

    private let theme: Theme
    private let selectionHanlder: SelectionHandler

    // MARK: - Public

    public init(theme: Theme = .default, handler: @escaping SelectionHandler) {
        self.theme = theme
        selectionHanlder = handler

        let albumsController = AlbumsViewController(theme: theme)
        super.init(rootViewController: albumsController)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private
}
