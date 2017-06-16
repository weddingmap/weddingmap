//
//  ProfileViewController.swift
//  weddingmap
//
//  Created by Kinki Lai on 2017/6/15.
//  Copyright © 2017年 wedding. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
class ProfileViewController: UIViewController {

    @IBOutlet var profieImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = FIRAuth.auth()?.currentUser {
        nameLabel.text = currentUser.displayName
            //for profile in currentUser.providerData {
               // let photoUrl = profile.photoURL?.absoluteString
               // var imgUrl = URL(string: photoUrl!)
                //var imageData = try? Data(contentsOf: imgUrl!)
               // profieImageView.image = UIImage(data: imageData!)
            //}
        }else
        {
            /*if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeView") {
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil) 
 
           }*/
            self.performSegue(withIdentifier: "showLogin", sender: nil)        }
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let currentUser = FIRAuth.auth()?.currentUser {
            nameLabel.text = currentUser.displayName
        }
    }
    @IBAction func logoutButton(_ sender: Any) {
        do {
            if let providerData = FIRAuth.auth()?.currentUser?.providerData {
                let userInfo = providerData[0]
                
                switch userInfo.providerID {
                case "google.com":
                    GIDSignIn.sharedInstance().signOut()
                    
                default:
                    break
                }
            }
            
            try FIRAuth.auth()?.signOut()
            
        } catch {
            let alertController = UIAlertController(title: "Logout Error", message: error.localizedDescription, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
         self.performSegue(withIdentifier: "showLogin", sender: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
