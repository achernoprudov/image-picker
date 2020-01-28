//
//  AssetsGridDataSource.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import Photos
import UIKit

class AssetsGridDataSource: NSObject {
    // MARK: - Aliases

    // MARK: - Instance variables

    let imagePickerContext: ImagePickerContext
    let album: PHAssetCollection

    // MARK: - Public

    init(imagePickerContext: ImagePickerContext, album: PHAssetCollection) {
        self.imagePickerContext = imagePickerContext
        self.album = album
        super.init()
    }

    // MARK: - Private
}

// MARK: - UICollectionViewDataSource

extension AssetsGridDataSource: UICollectionViewDataSource {
    func collectionView(
        _: UICollectionView,
        numberOfItemsInSection _: Int
    ) -> Int {}

    func collectionView(
        _: UICollectionView,
        cellForItemAt _: IndexPath
    ) -> UICollectionViewCell {}
}
