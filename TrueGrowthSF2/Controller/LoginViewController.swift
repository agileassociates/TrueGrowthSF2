//
//  LoginViewController.swift
//  TrueGrowthSF2
//
//  Created by Johny Babylon on 12/18/18.
//  Copyright © 2018 Agile Associates. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController {
    //@IBOutlet weak var fbLoginButton: LoginButton!
    
    @IBOutlet weak var trueGrowthLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        }
    @IBAction func googleSignInBtnPressed(_ sender: Any) {
    }
    
    @IBAction func facebookSignInBtnPressed(_ sender: Any) {
    }
    
        
    @IBAction func logInWithEmailBtnPressed(_ sender: Any) {
        let emailLoginVC = storyboard?.instantiateViewController(withIdentifier: "EmailLoginViewController")
        present(emailLoginVC!, animated: true, completion: nil)
    }
    

        // Do any additional setup after loading the view.
}
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
        // ...
    


