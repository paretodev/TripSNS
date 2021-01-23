//
//  LogInVC.swift
//  TravelTest2
//
//  Created by 한석희 on 1/13/21.
// yes

import UIKit

class MainViewController: UIViewController {
    //MARK:- outlets
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var motherVerticalStackView: UIStackView!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var buttonStackView: UIStackView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Individual StackView Custom
        logInButton.backgroundColor = .white
        registerButton.backgroundColor = .white
        logInButton.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 10
        //Spacing Between Stack Views
        motherVerticalStackView.setCustomSpacing(125, after: titleStackView)
        motherVerticalStackView.setCustomSpacing(30, after: buttonStackView)
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

//MARK:- 
