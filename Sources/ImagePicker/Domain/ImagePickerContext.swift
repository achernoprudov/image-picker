//
//  ImagePickerContext.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 28.01.2020.
//

/// Shared context for photo selection process
class ImagePickerContext {
    // MARK: - Aliases

    typealias SelectionHandler = ImagePickerController.SelectionHandler

    // MARK: - Instance variables

    let theme: Theme

    private let selectionHanlder: SelectionHandler

    // MARK: - Public

    init(
        theme: Theme,
        selectionHanlder: @escaping SelectionHandler
    ) {
        self.theme = theme
        self.selectionHanlder = selectionHanlder
    }

    // MARK: - Private
}
