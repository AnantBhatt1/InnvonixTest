//
//  LoginVC.swift
//  Innvonix Test
//
//  Created by Anant Bhatt on 03/02/23.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var emailLogin : String? = ""
    var passwordLogin : String? = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtEmail.text = emailLogin
        txtPassword.text = passwordLogin    }
    
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
    
    
    // MARK: - ButtonAction
    @IBAction func btnLoginAction(_ sender: UIButton) {
        
        
        
        if emailLogin! == "" {
            
            showAlert(message: "Please enter email")
        } else if passwordLogin == "" {
            
            showAlert(message: "Please enter Password")
        } else if !isValidEmail(emailLogin!) {
            
            showAlert(message: "Please enter valid email")
        } else {
            
            let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func btnMoveToSignUpAction(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: "SignUpVC") as! SignUpVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
