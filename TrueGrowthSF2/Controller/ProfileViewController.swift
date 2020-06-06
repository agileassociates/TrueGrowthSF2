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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let currentUser = Auth.auth().currentUser
        print(currentUser?.email)
        emailLabel.text = currentUser?.email
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
