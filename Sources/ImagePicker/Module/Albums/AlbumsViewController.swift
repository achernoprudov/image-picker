//
//  AlbumsViewController.swift
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import Photos
import UIKit

class AlbumsViewController: UIViewController {
    // MARK: - Widgets

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)

        tableView.register(AlbumTableCell.self, forCellReuseIdentifier: AlbumTableCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.allowsMultipleSelection = false

        return tableView
    }()

    // MARK: - Instance variables

    private let context: ImagePickerContext
    private let presenter: ImagePickerPresetnerProtocol
    private let imageManager = PHCachingImageManager.default()

    private var albums: [PHAssetCollection] = []

    // MARK: - Public

    init(context: ImagePickerContext, presenter: ImagePickerPresetnerProtocol) {
        self.context = context
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = context.theme.color.background

        toolbarItems = navigationController?.toolbarItems

        loadAlbums()
    }

    // MARK: - Private

    private func loadAlbums() {
        func addAll(_ result: PHFetchResult<PHAssetCollection>) {
            for index in 0 ..< result.count {
                let album = result[index]

                let fetchOptions = PHFetchOptions()
                fetchOptions.fetchLimit = 1

                if PHAsset.fetchAssets(in: album, options: fetchOptions).count > 0 {
                    albums.append(album)
                }
            }
        }

        let smartCollections = PHAssetCollection.fetchAssetCollections(
            with: .smartAlbum,
            subtype: .any,
            options: nil
        )
        addAll(smartCollections)

        let albumsCollection = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .any,
            options: nil
        )
        addAll(albumsCollection)
    }

    private func showDetails(for album: PHAssetCollection) {
        let gridController = AssetsGridViewController(
            context: context,
            album: album,
            presenter: presenter
        )
        navigationController?.pushViewController(gridController, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension AlbumsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetails(for: albums[indexPath.row])
    }
}

// MARK: - UITableViewDataSource

extension AlbumsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableCell.cellId, for: indexPath)
        guard let albumCell = cell as? AlbumTableCell else {
            return cell
        }

        let album = albums[indexPath.row]

        albumCell.albumTitle.attributedText = NSAttributedString(
            string: album.localizedTitle ?? "",
            attributes: [
                .font: context.theme.font.body,
                .foregroundColor: context.theme.color.foreground,
            ]
        )

        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 1

        let imageSize = CGSize(width: 84, height: 84)
        let imageContentMode: PHImageContentMode = .aspectFill
        if let asset = PHAsset.fetchAssets(in: album, options: fetchOptions).firstObject {
            let options = PHImageRequestOptions()
            options.isNetworkAccessAllowed = true

            imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: imageContentMode, options: options) { image, _ in
                albumCell.albumImageView.image = image
            }
        }

        return cell
    }
}
