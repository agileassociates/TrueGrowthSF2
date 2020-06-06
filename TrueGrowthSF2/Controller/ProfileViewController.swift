//
//  ProfileViewController.swift
//  TrueGrowthSF2
//
//  Created by Johny Babylon on 12/21/18.
//  Copyright © 2018 Agile Associates. All rights reserved.
//

import UIKit
import Firebase
import MobileCoreServices



class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    
    var profiles = [Profile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfiles()

        // Do any additional setup after loading the view.
        let currentUser = Auth.auth().currentUser
        print(currentUser?.email)
        emailLabel.text = currentUser?.email
        
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userEmail = Auth.auth().currentUser?.email
        ref.child("profile").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let useremail = value?["ztreddedgmail"] as? String ?? ""
            //let user = User(useremail: username)
            //print("\n\n the email in the profile is: ", value)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func loadProfiles() {
        Database.database().reference().child("profile").observe(.childAdded, with: { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                //print(dict)
                let email = dict["email"] as! String
                let photoUrl = dict["photoUrl"] as! String
                let profile = Profile(emailName: photoUrl, photoName: email )
                self.profiles.append(profile)
                //print("\n\n\n\n\nprofiles says>>>>>>>>>", email)
                let currentUser = Auth.auth().currentUser
                if currentUser?.email == email {
                    print("the current users email matches one found in database, its:  ", currentUser?.email)
                    
                    let photoImage = photoUrl
                    let url = NSURL(string: photoImage)
                    URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
                        
                        if error != nil {
                            print(error!)
                            return
                        }
                        DispatchQueue.main.async {
                            self.profileImage.image = UIImage(data: data!)
                        }
                        
                    }).resume()
                }
                self.tableView.reloadData()
            }
            
        })
    }
    
    @IBAction func addPhotoBtnPressed(_ sender: Any) {
    }
    @IBAction func logoutBtnPressed(_ sender: Any) {
        
        try! Auth.auth().signOut()

        
        let LoginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        present(LoginVC!, animated: true, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
