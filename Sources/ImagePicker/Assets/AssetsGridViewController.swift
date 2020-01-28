//
//  AssetsGridViewController.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import Photos
import UIKit

class AssetsGridViewController: UIViewController {
    // MARK: - Widgets

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        return collectionView
    }()

    // MARK: - Instance variables

    private let dataSource: AssetsGridDataSource

    // MARK: - Public

    public init(context: ImagePickerContext, album: PHAssetCollection) {
        dataSource = AssetsGridDataSource(context: context, album: album)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private
}
