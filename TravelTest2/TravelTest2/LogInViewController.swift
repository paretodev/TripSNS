//
//  LogInViewController.swift
//  TravelTest2
//
//  Created by 한석희 on 1/13/21.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var motherStackView: UIStackView!
    @IBOutlet weak var identificationStackView: UIStackView!
    @IBOutlet weak var findPasswordButtonStackView: UIStackView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        okButton.backgroundColor = .white
        okButton.layer.cornerRadius = 8
        //
        motherStackView.setCustomSpacing(15, after: identificationStackView)
        motherStackView.setCustomSpacing(50, after: findPasswordButtonStackView)
        //
        idTextField.attributedPlaceholder = NSAttributedString(string: "UserID", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        // Do any additional setup after loading the view.
    }

}
