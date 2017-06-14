//
//  SignUpViewController.swift
//  weddingmap
//
//  Created by Kinki Lai on 2017/6/13.
//  Copyright © 2017年 wedding. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordComfirmTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func registerAccount(_ sender: UIButton) {
        
        // Validate the input
        guard let emailAddress = emailTextField.text, emailAddress != "",
            let password = passwordTextField.text, password != "",
            let passwordComfirm = passwordComfirmTextField.text, passwordComfirm != "" else {
                
                let alertController = UIAlertController(title: "註冊錯誤", message: "請確認你的帳號、密碼是否正確輸入", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        
        guard passwordTextField.text == passwordComfirmTextField.text else {
            
            let alertController = UIAlertController(title: "密碼錯誤", message: "密碼輸入錯誤，密碼不一致", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        // Register the user account on Firebase
        FIRAuth.auth()?.createUser(withEmail: emailAddress, password: password, completion: { (user, error) in
            
            if let error = error {
                let alertController = UIAlertController(title: "註冊錯誤", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
           
            // Dismiss keyboard
            self.view.endEditing(true)
            
            // Send verification email
            user?.sendEmailVerification(completion: nil)
            
            let alertController = UIAlertController(title: "Email 認證", message: "我們剛剛向您的電子郵件地址發送確認電子郵件。請檢查您的收件箱，然後點擊該電子郵件中的驗證鏈接完成註冊", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                // Dismiss the current view controller
                self.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
            
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
