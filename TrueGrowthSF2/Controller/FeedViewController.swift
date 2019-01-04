//
//  FirstViewController.swift
//  TrueGrowthSF2
//
//  Created by Johny Babylon on 12/18/18.
//  Copyright © 2018 Agile Associates. All rights reserved.
//

import UIKit
import MobileCoreServices
import Firebase



class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var postButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.isHidden = true
        progressView.progress = 0.0
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func postBtnPressed(_ sender: Any) {
        postButton.isEnabled = false
        let profileImagePicker = UIImagePickerController()
        profileImagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        profileImagePicker.mediaTypes = [kUTTypeImage as String]
        profileImagePicker.delegate = self
        present(profileImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion:nil)

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let data = image.jpegData(compressionQuality: 0.5)
            let storageRef = Storage.storage().reference().child("photos/why_image.jpg")
            let uploadTask = storageRef.putData(data!, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    print("Uh-oh, an error occurred!")
                    print(error!)
                    self.postButton.isEnabled = true

                    return
                }
            
            }
            uploadTask.observe(.progress) { snapshot in
                // A progress event occurred
                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                    / Double(snapshot.progress!.totalUnitCount)
                //self.progressView.labelSize = 60
                //self.progressView.safePercent = 100
                self.progressView.isHidden = false
                self.progressView.setProgress(Float(percentComplete), animated: true)
                    print(snapshot.progress!)
                
                print("Percent complete is: ", percentComplete)
            }
            uploadTask.observe(.success) { snapshot in
                self.progressView.isHidden = true
                self.postButton.isEnabled = true


            }
        }
}
}
    
    

