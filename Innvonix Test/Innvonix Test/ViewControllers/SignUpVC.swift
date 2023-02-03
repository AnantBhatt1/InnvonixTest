//
//  SignUpVC.swift
//  Innvonix Test
//
//  Created by Anant Bhatt on 03/02/23.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Fuctions
    func showAlert(message : String){
        
        let alert = UIAlertController(title: "Innvonix Test", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    //MARK:- ButtonAction
    @IBAction func btnSignUpAction(_ sender: UIButton) {
        
        guard let name = txtName.text, let email = txtEmail.text, let password = txtPassword.text, let confirmPassword = txtConfirmPassword.text else {
            return
        }
        
        if name.isEmpty {
            
            showAlert(message: "Please enter Name")
        } else if email.isEmpty {
            
            showAlert(message: "Please enter Email")
        } else if !isValidEmail(email) {
            
            showAlert(message: "Please enter Valid Email")
        } else if password.isEmpty {
            
            showAlert(message: "Please enter Password")
        } else if confirmPassword.isEmpty {
            
            showAlert(message: "Please enter Confirm Password")
        } else if password != confirmPassword {
            
            showAlert(message: "Password should be match")
        } else {
            
            let vc = self.storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
            vc.emailLogin = email
            vc.passwordLogin = password
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func btnMoveToLoginAction(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
