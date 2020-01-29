//
//  AlbumsDataSource.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import Photos
import UIKit

class AlbumsDataSource: NSObject {
    // MARK: - Constants

    // MARK: - Instance variables

    var albumsCollection: PHFetchResult<PHAssetCollection> = PHFetchResult()

    private let imageManager = PHCachingImageManager.default()

    private let theme: Theme

    // MARK: - Public

    init(theme: Theme) {
        self.theme = theme
        super.init()

        albumsCollection = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .any,
            options: nil
        )
    }
}

// MARK: - UITableViewDataSource

extension AlbumsDataSource: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return albumsCollection.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableCell.cellId, for: indexPath)
        guard let albumCell = cell as? AlbumTableCell else {
            return cell
        }

        let album = albumsCollection[indexPath.row]

        albumCell.albumTitle.attributedText = NSAttributedString(
            string: album.localizedTitle ?? "",
            attributes: [
                .font: theme.font.body,
                .foregroundColor: theme.color.foreground,
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
