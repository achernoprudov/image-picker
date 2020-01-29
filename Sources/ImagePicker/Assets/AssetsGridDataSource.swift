//
//  AssetsGridDataSource.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import Photos
import UIKit

class AssetsGridDataSource: NSObject {
    // MARK: - Typealias

    typealias ReloadCallback = () -> Void

    // MARK: - Static

    static let videoCellId = "videoCollectionViewCell"
    static let assetCellId = "assetCollectionViewCell"

    static func registerCellIdentifiersForCollectionView(_ collectionView: UICollectionView?) {
        collectionView?.register(AssetCollectionViewCell.self, forCellWithReuseIdentifier: assetCellId)
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: videoCellId)
    }

    // MARK: - Instance variables

    private lazy var durationFormatter: DateComponentsFormatter = {
        let durationFormatter = DateComponentsFormatter()
        durationFormatter.unitsStyle = .positional
        durationFormatter.zeroFormattingBehavior = [.pad]
        durationFormatter.allowedUnits = [.minute, .second]
        return durationFormatter
    }()

    private lazy var scale: CGFloat = UIScreen.main.scale

    private let imageManager = PHCachingImageManager.default()
    private let album: PHAssetCollection

    let context: ImagePickerContext
    var fetchResult: PHFetchResult<PHAsset> = PHFetchResult<PHAsset>()

    var reloadCallback: ReloadCallback?

    // MARK: - Public

    init(context: ImagePickerContext, album: PHAssetCollection) {
        self.context = context
        self.album = album
        super.init()
    }

    func loadAssets() {
        DispatchQueue.global(qos: .userInteractive).async { [album, context] in
            let fetchResult = PHAsset.fetchAssets(in: album, options: context.options.fetchOptions)
            DispatchQueue.main.async { [weak self] in
                self?.fetchResult = fetchResult
                self?.reloadCallback?()
            }
        }
    }

    // MARK: - Private

    private func loadImage(for asset: PHAsset, in cell: AssetCollectionViewCell) {
        // Cancel any pending image requests
        if cell.tag != 0 {
            imageManager.cancelImageRequest(PHImageRequestID(cell.tag))
        }

        let imageTag = imageManager.requestImage(
            for: asset,
            targetSize: cell.bounds.size,
            contentMode: .aspectFill,
            options: context.options.imageOptions
        ) { image, _ in
            cell.imageView.image = image
        }

        cell.tag = Int(imageTag)
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
        let asset = fetchResult[indexPath.row]
        let animationsWasEnabled = UIView.areAnimationsEnabled
        let cell: AssetCollectionViewCell

        UIView.setAnimationsEnabled(false)
        if asset.mediaType == .video {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.videoCellId, for: indexPath) as! VideoCollectionViewCell
            let videoCell = cell as! VideoCollectionViewCell
            videoCell.durationLabel.text = durationFormatter.string(from: asset.duration)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.assetCellId, for: indexPath) as! AssetCollectionViewCell
        }
        UIView.setAnimationsEnabled(animationsWasEnabled)

        cell.theme = context.theme

        loadImage(for: asset, in: cell)

        cell.isAccessibilityElement = true
        cell.accessibilityTraits = UIAccessibilityTraits.button

        return cell
    }
}
