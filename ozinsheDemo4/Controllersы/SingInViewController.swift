//
//  ViewController.swift
//  ozinsheDemo4
//
//  Created by Ернат on 12.08.2023.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class SingInViewController: UIViewController {
    @IBOutlet weak var emailTextField: TextFieldWithPadding!
    @IBOutlet weak var passwordTextField: TextFieldWithPadding!
    @IBOutlet weak var singinButton: UIButton!
    @IBOutlet weak var registrationSinginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        hideKeyboardWhenTappedAround()
    }
    
    func configureViews() {
        emailTextField.layer.cornerRadius = 12.0
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        passwordTextField.layer.cornerRadius = 12.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        singinButton.layer.cornerRadius = 12.0
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func textFieldEditingDidBegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
 
    @IBAction func textFieldEditingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
    }

    @IBAction func showPassword(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @IBAction func singin(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        SVProgressHUD.show()

        let parameters = ["email": email,
                          "password": password]

        AF.request(Urls.SIGN_IN_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let token = json["accessToken"].string {
                    Storage.sharedInstance.accessToken = token
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    self.startApp()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }

    @IBAction func goToRegistration(_ sender: Any) {
        let registrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegistratsionViewController")
        registrationViewController?.modalPresentationStyle = .fullScreen
        self.present(registrationViewController!, animated: true, completion: nil)
    }
    
    func startApp() {
        let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
        tabViewController?.modalPresentationStyle = .fullScreen
        self.present(tabViewController!, animated: true, completion: nil)
    }
}



