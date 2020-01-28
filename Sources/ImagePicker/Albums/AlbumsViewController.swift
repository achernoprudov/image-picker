//
//  AlbumsViewController.swift
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import Photos
import UIKit

class AlbumsViewController: UIViewController {
    // MARK: - Constants

    private let cellId = "albumCell"

    // MARK: - Aliases

    // MARK: - Widgets

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    // MARK: - Instance variables

    private var albumsCollection: PHFetchResult<PHAssetCollection> = PHFetchResult()

    // MARK: - Public

    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        albumsCollection = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .any,
            options: nil
        )
    }

    // MARK: - Private
}

extension AlbumsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return albumsCollection.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        let album = albumsCollection[indexPath.row]
        cell.textLabel?.text = album.localizedTitle

        return cell
    }
}

extension AlbumsViewController: UITableViewDelegate {}
