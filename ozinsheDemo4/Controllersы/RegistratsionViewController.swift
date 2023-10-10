//
//  RegistratsionViewController.swift
//  ozinsheDemo4
//
//  Created by Ернат on 06.09.2023.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import Localize_Swift

class RegistratsionViewController: UIViewController {
    @IBOutlet weak var registrationEmailTextField: TextFieldWithPadding!
    @IBOutlet weak var registrationPasswordTextField: TextFieldWithPadding!
    @IBOutlet weak var registrationPasswordTextField2: TextFieldWithPadding!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var bigRegistrationButton: UIButton!
    @IBOutlet weak var backSingInViewController: UIBarButtonItem?
    @IBOutlet weak var registrationLabel: UILabel!
    @IBOutlet weak var fillInTheDatailsLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    @IBOutlet weak var accountCheckLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureViews()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStringTranslation()
    }
    
    func getStringTranslation() {
        registrationLabel.text = "REGISTRATION".localized()
        fillInTheDatailsLabel.text = "FILL_IN_THE_DATAILS".localized()
        passwordLabel.text = "PASSWORD".localized()
        repeatPasswordLabel.text = "REPEAT_PASSWORD".localized()
        accountCheckLabel.text = "DO_YOU_HAVE_AN_ACCOUNT".localized()
        registrationButton.setTitle("REGISTRATION".localized(), for: .normal)
        bigRegistrationButton.setTitle("REGISTRATION".localized(), for: .normal)
    }
    
    
    @IBAction func backSignIn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    //Для дизайна текстфиилд
    func configureViews() {
        //закругление краев
        registrationEmailTextField.layer.cornerRadius = 12.0
        //ширина линии
        registrationEmailTextField.layer.borderWidth = 1.0
        //цвет
        registrationEmailTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
      
        registrationPasswordTextField.layer.cornerRadius = 12.0
        registrationPasswordTextField.layer.borderWidth = 1.0
        registrationPasswordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        registrationPasswordTextField2.layer.cornerRadius = 12.0
        registrationPasswordTextField2.layer.borderWidth = 1.0
        registrationPasswordTextField2.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
        registrationButton.layer.cornerRadius = 12.0
        
    }
    //функция для сварачивание клавиатуры (нажав по экрану)
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    //после нажатия на экран клава скрывается(для обеих тескстфиилдов)
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func textFieldEditingDidBegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
    @IBAction func sjowPassword(_ sender: Any) {
        registrationPasswordTextField.isSecureTextEntry = !registrationPasswordTextField.isSecureTextEntry
    }
    @IBAction func showPassword(_ sender: Any) {
        registrationPasswordTextField2.isSecureTextEntry = !registrationPasswordTextField2.isSecureTextEntry
    }
    @IBAction func registration(_ sender: Any) {
        let email = registrationEmailTextField.text!
        let password = registrationPasswordTextField.text!
        let passowrd2 = registrationPasswordTextField2.text!
        
        SVProgressHUD.show()

        let parameters = ["email": email,
                          "password": password]
        //Запрос на АПИ.             //Метод ПОСТ запроса                //ДляДжейсонФотмата
        AF.request(Urls.SIGN_IN_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            //Статус код
            if response.response?.statusCode == 200 {
                //ПреообразовываемВДжейсон
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                //ИщемАксесТоекен
                if let token = json["accessToken"].string {
                    //Запись
                    Storage.sharedInstance.accessToken = token
                    //ЗаписьДляТогоЧтобыЗапускатьПриложениеБезАвторизации
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    
                    //ЗапускПриложение
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
    func startApp() {
        let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
        //НаВесьОтдкльныйЭкран
        tabViewController?.modalPresentationStyle = .fullScreen
        self.present(tabViewController!, animated: true, completion: nil)
    }
    }

