//
//  LogInVC.swift
//  TravelTest2
//
//  Created by 한석희 on 1/13/21.
// yes

import UIKit

class MainViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var motherVerticalStackView: UIStackView!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var buttonStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialUI()
    }
    
    
    
    //MARK:- Helper Functions
    func configureInitialUI(){
        
        logInButton.backgroundColor = .white
        registerButton.backgroundColor = .white
        logInButton.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 10
        
        motherVerticalStackView.setCustomSpacing(120, after: titleStackView)
        motherVerticalStackView.setCustomSpacing(30, after: buttonStackView)
        
    }

    //MARK:- End of VC.
}
