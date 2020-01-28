//
//  AlbumsDataSource.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import Photos
import UIKit

private let cellId = "albumCell"

class AlbumsDataSource: NSObject, UITableViewDataSource {
    // MARK: - Constants

    // MARK: - Instance variables

    private var albumsCollection: PHFetchResult<PHAssetCollection> = PHFetchResult()

    private let imageManager = PHCachingImageManager.default()

    // MARK: - Public

    // MARK: - Private

    override init() {
        super.init()

        albumsCollection = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .any,
            options: nil
        )
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return albumsCollection.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        let album = albumsCollection[indexPath.row]
        cell.textLabel?.attributedText = NSAttributedString(
            string: album.localizedTitle ?? "",
            attributes: [
                .font: UIFont.systemFont(ofSize: 18),
                .foregroundColor: UIColor.black,
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
                guard let image = image else { return }
                cell.imageView?.image = image
            }
        }

        return cell
    }
}