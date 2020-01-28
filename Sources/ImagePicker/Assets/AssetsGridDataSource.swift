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

    private static var fetchOptions: PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false),
        ]

        let rawMediaTypes: [PHAssetMediaType] = [.image, .video]
        let predicate = NSPredicate(format: "mediaType IN %@", rawMediaTypes)
        fetchOptions.predicate = predicate
        return fetchOptions
    }

    private let imageManager = PHCachingImageManager.default()
    private let album: PHAssetCollection

    let imagePickerContext: ImagePickerContext
    var fetchResult: PHFetchResult<PHAsset> = PHFetchResult<PHAsset>()

    // MARK: - Public

    init(imagePickerContext: ImagePickerContext, album: PHAssetCollection) {
        self.imagePickerContext = imagePickerContext
        self.album = album
        super.init()
    }

    func registerCell(for _: UICollectionView) {}

    // MARK: - Private

    private func loadAssets() {
        DispatchQueue.global(qos: .userInteractive).async { [album] in
            let fetchResult = PHAsset.fetchAssets(in: album, options: AssetsGridDataSource.fetchOptions)
            DispatchQueue.main.async { [weak self] in
                self?.fetchResult = fetchResult
//                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension AssetsGridDataSource: UICollectionViewDataSource {
    func collectionView(
        _: UICollectionView,
        numberOfItemsInSection _: Int
    ) -> Int {
        return fetchResult.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AssetCollectionViewCell.cellId,
            for: indexPath
        )

        guard let assetCell = cell as? AssetCollectionViewCell else {
            return cell
        }

        return assetCell
    }
}
