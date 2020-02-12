//
//  Config+Options.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 12.02.2020.
//

import Photos

extension Config {
    var imageOptions: PHImageRequestOptions {
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        return options
    }

    var fetchOptions: PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false),
        ]

        let rawMediaTypes = mediaTypes.map { $0.rawValue }
        fetchOptions.predicate = NSPredicate(format: "mediaType IN %@", rawMediaTypes)
        return fetchOptions
    }

    var albumPreviewOptions: PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 1

        let rawMediaTypes = mediaTypes.map { $0.rawValue }
        fetchOptions.predicate = NSPredicate(format: "mediaType IN %@", rawMediaTypes)
        return fetchOptions
    }
}
