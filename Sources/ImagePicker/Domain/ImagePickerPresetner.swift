//
//  ImagePickerPresetner.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 29.01.2020.
//

import Photos

protocol ImagePickerPresetnerProtocol {
    var selected: Set<PHAsset> { get }

    func toggle(selectionOf asset: PHAsset)
}

class ImagePickerPresetner: ImagePickerPresetnerProtocol {
    // MARK: - Aliases

    // MARK: - Instance variables

    var selected = Set<PHAsset>()

    // MARK: - Public

    init() {}

    func toggle(selectionOf asset: PHAsset) {
        if selected.contains(asset) {
            selected.remove(asset)
        } else {
            selected.insert(asset)
        }
        notifyChangeSelectionHandler()
    }

    func select(_: PHAsset) {}

    // MARK: - Private

    private func notifyChangeSelectionHandler() {
        // TODO: change done button state
    }
}
