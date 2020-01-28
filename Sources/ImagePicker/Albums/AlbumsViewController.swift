//
//  AlbumsViewController.swift
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import Photos
import UIKit

class AlbumsViewController: UIViewController {
    // MARK: - Aliases

    // MARK: - Widgets

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.delegate = self
        tableView.dataSource = datasource

        return tableView
    }()

    private let datasource = AlbumsDataSource()

    // MARK: - Instance variables

    // MARK: - Public

    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private
}

// MARK: - UITableViewDelegate

extension AlbumsViewController: UITableViewDelegate {}
