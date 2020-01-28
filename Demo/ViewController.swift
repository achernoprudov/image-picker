//
//  ViewController.swift
//  Demo
//
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import ImagePicker
import Photos
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func presentImagePicker() {
        let imagePicker = ImagePickerController { selectedAssets in
            print("Selected assets: \(selectedAssets)")
        }
        present(imagePicker, animated: true, completion: nil)
    }
}
