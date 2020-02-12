//
//  AssetsGridViewController.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import Photos
import UIKit

class AssetsGridViewController: UIViewController {
    // MARK: - Constants

    private static let videoCellId = "videoCollectionViewCell"
    private static let assetCellId = "assetCollectionViewCell"

    // MARK: - Widgets

    private lazy var collectionViewFlowLayout = UICollectionViewFlowLayout()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: UIScreen.main.bounds,
            collectionViewLayout: collectionViewFlowLayout
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.register(AssetCollectionViewCell.self, forCellWithReuseIdentifier: Self.assetCellId)
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: Self.videoCellId)

        return collectionView
    }()

    // MARK: - Instance variables

    private let presenter: ImagePickerPresetnerProtocol
    private let context: ImagePickerContext
    private let imageManager = PHCachingImageManager.default()
    private let album: PHAssetCollection

    private lazy var scale: CGFloat = UIScreen.main.scale

    private lazy var durationFormatter: DateComponentsFormatter = {
        let durationFormatter = DateComponentsFormatter()
        durationFormatter.unitsStyle = .positional
        durationFormatter.zeroFormattingBehavior = [.pad]
        durationFormatter.allowedUnits = [.minute, .second]
        return durationFormatter
    }()

    private var fetchResult: PHFetchResult<PHAsset> = PHFetchResult<PHAsset>()

    // MARK: - Public

    public init(
        context: ImagePickerContext,
        album: PHAssetCollection,
        presenter: ImagePickerPresetnerProtocol
    ) {
        self.context = context
        self.album = album
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        title = album.localizedTitle
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadAssets()
        updateToolbar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFlowLayout()
    }

    // MARK: - Private

    private func updateToolbar() {
        toolbarItems = navigationController?.toolbarItems
    }

    private func updateFlowLayout() {
        let itemSpacing: CGFloat = 2
        let itemsPerRow: CGFloat = 4
        let itemWidth = (collectionView.bounds.width - CGFloat(itemsPerRow - 1) * itemSpacing) / CGFloat(itemsPerRow)
        let itemSize = CGSize(width: itemWidth, height: itemWidth)

        collectionViewFlowLayout.minimumLineSpacing = itemSpacing
        collectionViewFlowLayout.minimumInteritemSpacing = itemSpacing
        collectionViewFlowLayout.itemSize = itemSize
    }

    func loadAssets() {
        // fetching many assets could last for long time.
        // so move it from main thread
        DispatchQueue.global(qos: .userInteractive).async { [album, context] in
            let fetchResult = PHAsset.fetchAssets(in: album, options: context.config.fetchOptions)
            DispatchQueue.main.async { [weak self] in
                self?.fetchResult = fetchResult
                self?.collectionView.reloadData()
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
            options: context.config.imageOptions
        ) { image, _ in
            cell.imageView.image = image
        }

        cell.tag = Int(imageTag)
    }
}

// MARK: - UICollectionViewDataSource

extension AssetsGridViewController: UICollectionViewDataSource {
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

// MARK: - UICollectionViewDelegate

extension AssetsGridViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        let asset = fetchResult[indexPath.row]
        presenter.toggle(selectionOf: asset)
        collectionView.reloadItems(at: [indexPath])
        return false
    }

    func collectionView(
        _: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if let assetCell = cell as? AssetCollectionViewCell {
            let asset = fetchResult[indexPath.row]
            assetCell.isAssetSelected = presenter.selected.contains(asset)
        }
    }
}
