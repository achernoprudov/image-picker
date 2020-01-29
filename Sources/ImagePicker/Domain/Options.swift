//
//  Options.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import Photos

class Options {
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

//        let rawMediaTypes: [PHAssetMediaType] = [.image, .video]
//        let predicate = NSPredicate(format: "mediaType IN %@", rawMediaTypes)
//        fetchOptions.predicate = predicate
        return fetchOptions
    }
}
