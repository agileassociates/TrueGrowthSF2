//
//  LoginViewController.swift
//  TrueGrowthSF2
//
//  Created by Johny Babylon on 12/18/18.
//  Copyright © 2018 Agile Associates. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    //, FBSDKLoginButtonDelegate
    
    //@IBOutlet weak var fbLoginButton: LoginButton!
    
    @IBOutlet weak var trueGrowthLogo: UIImageView!
    
    //@IBOutlet weak var facebookLoginBtn: FBSDKLoginButton!
    
    @IBOutlet weak var facebookLoginBtn: UIButton!
    
    //Variables
    let loginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //facebookLoginBtn.delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        }
    
    @IBAction func googleSignInBtnPressed(_ sender: Any) {
        if GIDSignIn.sharedInstance()?.signIn() != nil {
            print("Suceess")
        } else {
            print("Login Error!!!!!!!!!!!!!!!!!!!!!!!!")
        }
        

        
    }
    
    
    @IBAction func facebookSignInBtnPressed(_ sender: Any) {
        loginManager.logIn(permissions: ["email", "public_profile"], from: self) { (result, error) in
            if let error = error {
                debugPrint("couldnt logout facebook", error)
            } else if result!.isCancelled {
                print("facebook login cancelled")
            } else {
                let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.tokenString)!)
                Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                    if let error = error {
                        debugPrint("couldnt logout facebook", error)
                        return
                    }
                    GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start {
                        (connection, result, err) in
                        if err != nil {
                            print("Failed graph request", err!)
                        }
                        if let data = result as? NSDictionary
                        {
                            // if no FB email, set name to email
                            if data.object(forKey: "email") == nil {
                                
                            let name =  data.object(forKey: "name")
                            var formattedName = (name! as AnyObject).replacingOccurrences(of: " ", with: "")
                            formattedName += "@truegrowthsf.org"
                                Auth.auth().currentUser?.updateEmail(to: (formattedName as! AnyObject) as! String, completion: { (error) in
                                    if err != nil {
                                        print("Success")
                                    } else {
                                        print(error)
                                    }
                                })
                            }
                        }
                    }
                    
                    let TabBC =  self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                    self.present(TabBC!, animated: true, completion: nil)
                }
            }
            
        }
        
    }
    
        
    @IBAction func logInWithEmailBtnPressed(_ sender: Any) {
        let emailLoginVC = storyboard?.instantiateViewController(withIdentifier: "EmailLoginViewController")
        present(emailLoginVC!, animated: true, completion: nil)
    }
    
    func firebaseLogin(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
        }
    }
    
    func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
        
        if let error = error {
            debugPrint("failed facebook login", error)
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: (result.token?.tokenString)!)
        //firebaseLogin(credential)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                debugPrint("failed facebook login", error)

                return
            }
            // User is signed in
            // ...
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton!) {
        
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
    


