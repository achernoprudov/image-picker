//
//  ImagePickerPresetner.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 29.01.2020.
//

import Photos
import UIKit

/// Common presenter for all image picking process
@objc protocol ImagePickerPresetnerProtocol: NSObjectProtocol {
    var selected: Set<PHAsset> { get }

    func toggle(selectionOf asset: PHAsset)

    @objc func complete()

    @objc func close()
}

class ImagePickerPresetner: NSObject, ImagePickerPresetnerProtocol {
    // MARK: - Aliases

    typealias ChangeSelectionHandler = () -> Void

    // MARK: - Instance variables

    var selected = Set<PHAsset>()

    private let selectionHandler: ImagePickerController.SelectionHandler

    weak var viewController: UIViewController?

    // MARK: - Public

    init(selectionHandler: @escaping ImagePickerController.SelectionHandler) {
        self.selectionHandler = selectionHandler
        super.init()
    }

    func toggle(selectionOf asset: PHAsset) {
        if selected.contains(asset) {
            selected.remove(asset)
        } else {
            selected.insert(asset)
        }
        Notifications.postAssetsSelectionChanged(to: selected.count)
    }

    func complete() {
        viewController?.dismiss(animated: true, completion: {
            let result = Array(self.selected)
            self.selectionHandler(result)
        })
    }

    func close() {
        viewController?.dismiss(animated: true, completion: {
            self.selectionHandler([])
        })
    }

    // MARK: - Private
}
