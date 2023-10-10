//
//  PersonalDataViewController.swift
//  ozinsheDemo4
//
//  Created by Ернат on 09.10.2023.
//

import UIKit

class PersonalDataViewController: UIViewController {

    @IBOutlet weak var dateOfBirdhLabel: UILabel!
    @IBOutlet weak var telaphoneLabel: UILabel!
    @IBOutlet weak var personalDataLabel: UILabel!
    @IBOutlet weak var yourNameLabel: UILabel!
    @IBOutlet weak var returnToProfileButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureViews()
    }
    
    func configureViews() {
        yourNameLabel.text = "YOUR_NAME".localized()
        telaphoneLabel.text = "TELEPHONE".localized()
        dateOfBirdhLabel.text = "DATA_OF_BIRTH".localized()
    }
    
    @IBAction func returnToProfileButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
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
