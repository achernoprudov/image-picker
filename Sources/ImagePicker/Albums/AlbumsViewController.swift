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
        tableView.dataSource = datasource
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsMultipleSelection = false

        return tableView
    }()

    // MARK: - Instance variables

    private let theme: Theme
    private lazy var datasource = AlbumsDataSource(theme: theme)

    // MARK: - Public

    init(theme: Theme) {
        self.theme = theme
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
        view.backgroundColor = theme.color.background
    }

    // MARK: - Private
}

// MARK: - UITableViewDelegate

extension AlbumsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
