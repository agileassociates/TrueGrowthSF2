//
//  EmailLoginViewController.swift
//  TrueGrowthSF2
//
//  Created by Johny Babylon on 12/19/18.
//  Copyright © 2018 Agile Associates. All rights reserved.
//

import UIKit

class EmailLoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        if emailTxtField.text != nil && passwordTxtField.text != nil {
            AuthService.instance.loginUser(withEmail: emailTxtField.text!, andPassword: passwordTxtField.text!, loginComplete: { (success, loginError) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print(String(describing: loginError?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.emailTxtField.text!, andPassword: self.passwordTxtField.text!, userCreationComplete:{ (success, registrationError) in
                    if success {
                        AuthService.instance.loginUser(withEmail: self.emailTxtField.text!, andPassword: self.passwordTxtField.text!, loginComplete:{(success, nil) in
                            self.dismiss(animated: true, completion: nil)
                        })
                    } else {
                        print(String(describing: registrationError?.localizedDescription))
                    }
            })
        })
    }
 }

}

