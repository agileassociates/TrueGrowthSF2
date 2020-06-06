//
//  CameraTwoViewController.swift
//  TrueGrowthSF2
//
//  Created by Johny Babylon on 6/7/20.
//  Copyright © 2020 Agile Associates. All rights reserved.
//

import UIKit
import MobileCoreServices
import Firebase

class CameraTwoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var selectPhotoLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        shareButton.isEnabled = false
        shareButton.backgroundColor = UIColor.gray
        progressView.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        photoImage.addGestureRecognizer(tapGesture)
        photoImage.isUserInteractionEnabled = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        /*
         let profileImagePicker = UIImagePickerController()
         profileImagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
         profileImagePicker.mediaTypes = [kUTTypeImage as String]
         profileImagePicker.delegate = self
         present(profileImagePicker, animated: true, completion: nil)
         */
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedImage = image
            photoImage.image = image
        }
        picker.dismiss(animated: true, completion:nil)
        shareButton.isEnabled = true
        shareButton.backgroundColor = #colorLiteral(red: 0.001213557567, green: 0.4273873731, blue: 0.001882945061, alpha: 1)
        selectPhotoLabel.isHidden = true
        
    }
    
    
    
    
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        if let image = self.selectedImage {
            shareButton.isEnabled = false
            let uid = Int.random(in: 1...1000000)
            let data = image.jpegData(compressionQuality: 0.5)
            let currentUser = Auth.auth().currentUser
            let storageRef = Storage.storage().reference().child("profiles").child(currentUser!.uid).child(String(uid))
            let uploadTask = storageRef.putData(data!, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    print("Uh-oh, an error occurred!")
                    print(error!)
                    self.shareButton.isEnabled = true
                    return
                }
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url?.absoluteString else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    let ref = Database.database().reference()
                    //ref.child("posts").child((currentUser?.uid)!).setValue(["photoUrl": downloadURL, "caption": caption])
                    let key = ref.child("profile").childByAutoId().key
                    let post = ["uid": currentUser?.uid,
                                "email": currentUser?.email,
                                "photoUrl": downloadURL,
                                "UUID": key
                    ]
                    let childUpdates = ["/profile/\(key)": post]
                    //let childUpdates = ["/posts/\(key)": post,
                    //"/user-posts/\(currentUser?.uid)/\(key)/": post]
                    ref.updateChildValues(childUpdates)
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
                self.shareButton.isEnabled = true
                if let nav = self.navigationController {
                    nav.popViewController(animated: true)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }


}
