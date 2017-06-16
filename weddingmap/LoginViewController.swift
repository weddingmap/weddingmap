//
//  LoginViewController.swift
//  weddingmap
//
//  Created by Kinki Lai on 2017/6/16.
//  Copyright © 2017年 wedding. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        // Validate the input
        guard let emailAddress = emailTextField.text, emailAddress != "",
            let password = passwordTextField.text, password != "" else {
                
                let alertController = UIAlertController(title: "登入錯誤", message: "請正確輸人帳號和密碼.", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        
        // Perform login by calling Firebase APIs
        FIRAuth.auth()?.signIn(withEmail: emailAddress, password: password, completion: { (user, error) in
            
            if let error = error {
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            // Email verification
            guard let currentUser = user, currentUser.isEmailVerified else {
                let alertController = UIAlertController(title: "登入錯誤", message: "您還沒有確認您的電子郵件地址。當您註冊時，我們向您發送了一封電子郵件。請點擊該電子郵件中的驗證鏈接。如果您需要我們再次發送確認郵件，請點擊重新發送電子郵件。", preferredStyle: .alert)
                
                let okayAction = UIAlertAction(title: "重寄 email", style: .default, handler: { (action) in
                    user?.sendEmailVerification(completion: nil)
                })
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            
            // Dismiss keyboard
            self.view.endEditing(true)
            
            self.navigationController?.popToRootViewController(animated: true)
           
            
        })
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
