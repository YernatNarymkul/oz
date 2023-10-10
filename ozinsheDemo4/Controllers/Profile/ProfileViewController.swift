//
//  ProfileViewController.swift
//  ozinsheDemo4
//
//  Created by Ернат on 13.08.2023.
//

import UIKit
import Localize_Swift

class ProfileViewController: UIViewController, LanguageProtocol {
    @IBOutlet weak var myProfileLabel: UILabel!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var personalDataButton: UIButton!
    @IBOutlet weak var adsLabel: UILabel!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var termsAndConditionsButton: UIButton!
    @IBOutlet weak var profile: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

        override func viewWillAppear(_ animated: Bool) {
            configureViews()
        }
    
    func configureViews() {
        myProfileLabel.text = "MY_PROFILE".localized()
        languageButton.setTitle("LANGUAGE".localized(), for: .normal)
        adsLabel.text = "ADS".localized()
        profile.title = "PROFILE".localized()
        personalDataButton.setTitle("PERSONAL_DATA".localized(), for: .normal)
        changePasswordButton.setTitle("CHENGE_PASSSWORD".localized(), for: .normal)
        termsAndConditionsButton.setTitle("TERMS_AND_CONDITIONS".localized(), for: .normal)
        darkModeLabel.text = "DARK_MODE".localized()
        
        
        if Localize.currentLanguage() == "ru" {
            languageLabel.text = "Русский"
        }
        if Localize.currentLanguage() == "kk" {
            languageLabel.text = "Қазақша"
        }
        if Localize.currentLanguage() == "en" {
            languageLabel.text = "English"
        }
    }
    
    
    @IBAction func changePasswordButtonTapped(_ sender: Any) {
        let registrationVC = storyboard?.instantiateViewController(withIdentifier: "RegistratsionViewController") as! RegistratsionViewController
        
        registrationVC.modalPresentationStyle = .overFullScreen
        
        present(registrationVC, animated: true, completion: nil)
    }
    
    @IBAction func personalDataButton(_ sender: Any) {
        let personalDataVC = storyboard?.instantiateViewController(withIdentifier: "PersonalDataViewController") as! PersonalDataViewController

        personalDataVC.modalPresentationStyle = .overFullScreen

        present(personalDataVC, animated: true, completion: nil)
    }
    
    @IBAction func languageShow(_ sender: Any) {
        let languageVC = storyboard?.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        
        languageVC.modalPresentationStyle = .overFullScreen
        
        languageVC.delegate = self
        
        present(languageVC, animated: true, completion: nil)
    }
    
    @IBAction func logaut(_ sender: Any) {
        let logoutVC = storyboard?.instantiateViewController(withIdentifier: "LogOutViewController") as! LogOutViewController
        
        logoutVC.modalPresentationStyle = .overFullScreen
        
        present(logoutVC, animated: true, completion: nil)
    }

    
    func languageDidChange() {
        configureViews()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
