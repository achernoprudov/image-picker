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
        tableView.estimatedRowHeight = 100
        tableView.allowsMultipleSelection = false

        return tableView
    }()

    // MARK: - Instance variables

    private let context: ImagePickerContext
    private let presenter: ImagePickerPresetnerProtocol
    private lazy var datasource = AlbumsDataSource(theme: context.theme)

    // MARK: - Public

    init(context: ImagePickerContext, presenter: ImagePickerPresetnerProtocol) {
        self.context = context
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        title = "Albums"
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toolbarItems = navigationController?.toolbarItems
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        toolbarItems = []
    }

    // MARK: - Private

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
        showDetails(for: datasource.albumsCollection[indexPath.row])
    }
}
