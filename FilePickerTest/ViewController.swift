//
//  ViewController.swift
//  FilePickerTest
//
//  Created by David Barkman on 2/11/22.
//

import UIKit
import UniformTypeIdentifiers

class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    @IBAction func getFileTapped(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.png, .jpeg, .gif, .pdf], asCopy: true)
         documentPicker.delegate = self
         documentPicker.allowsMultipleSelection = false
         documentPicker.modalPresentationStyle = .fullScreen
         present(documentPicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        guard controller.documentPickerMode == .import, let url = urls.first, let image = UIImage(contentsOfFile: url.path) else { return }
        let url = urls.first
        
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: url!.path)
            let size = attr[FileAttributeKey.size] as! UInt64
            let fileExtension = url?.pathExtension
            
            let uti = UTType(filenameExtension: fileExtension!)
            if uti!.conforms(to: .image) {
                print("it's an image!")
            } else {
                print("not an image 😭")
            }
            
            print("URL: \(url)")
            print("Size: \(size)")
            if size <= 2000000 {
                print("file ok")
            } else {
                print("file too big!")
            }
            print("Type: \(fileExtension)")
        } catch {
            print(error)
        }

        controller.dismiss(animated: true)
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
    }

}

