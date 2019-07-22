//
//  AppDelegate.swift
//  TrueGrowthSF2
//
//  Created by Johny Babylon on 12/18/18.
//  Copyright © 2018 Agile Associates. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FBSDKLoginKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    
    
    

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = [:]) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
       /*if Auth.auth().currentUser == nil {
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let loginVC = storyboard.instantiateViewController(withIdentifier:"LoginViewController")
                self.window?.rootViewController?.present(loginVC, animated: true, completion: nil)
                self.window?.makeKeyAndVisible()
            }
        } */

        //FB Login
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            debugPrint("Couldnt log in W/ Google: \(error)")
        } else {
            print("                    logged in with Google")
            
            guard let controller = GIDSignIn.sharedInstance()?.uiDelegate as? LoginViewController else {
                return
            }
            guard let authentication = user.authentication else {
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            controller.firebaseLogin(credential)
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let TabBC = storyboard.instantiateViewController(withIdentifier: "TabBarController")
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = TabBC
            window?.makeKeyAndVisible()
            
            //controller.dismiss(animated: true)
            
            //self.window?.rootViewController?.dismiss(animated: false, completion: nil)
            
            
            /*let topController = UIApplication.shared.keyWindow?.rootViewController
             let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
             topController!.present(newViewController, animated: true, completion: nil) */
            
            
            //
            //let TabBC =  storyboard.instantiateViewController(withIdentifier: "TabBarController")
//             //controller.present(TabBC, animated: false, completion: nil)
//            let rootViewController = self.window!.rootViewController as! UINavigationController;
//            rootViewController.pushViewController(TabBC, animated: true);
            
            //let TabBC =  storyboard.instantiateViewController(withIdentifier: "TabBarController")
//            let appDelegate = UIApplication.shared.delegate
//            appDelegate?.window??.rootViewController = TabBC

            //self.window?.rootViewController = TabBC
            //self.window?.makeKeyAndVisible()



        }
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let returnFB = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        
        return returnFB
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        AppEventsLogger.activate(application)

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /*
     func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let appId: String = SDKSettings.appId
        if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" {
            return SDKApplicationDelegate.shared.application(app, open: url, options: options)
        }
        return false
    }
    */
 

    
    
    

}

