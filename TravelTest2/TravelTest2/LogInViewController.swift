//
//  LogInViewController.swift
//  TravelTest2
//
//  Created by 한석희 on 1/13/21.
//

import UIKit

class LogInViewController: UIViewController {
    
    //MARK:- For Layout
    @IBOutlet weak var motherStackView: UIStackView!
    @IBOutlet weak var identificationStackView: UIStackView!
    @IBOutlet weak var findPasswordButtonStackView: UIStackView!
    //MARK:- OK button
    @IBOutlet weak var okButton: UIButton!
    //MARK:- Text Fields
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //MARK:- Action Back Button Action
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetting()
    }

    
    
    
    
    
    
    
    
    @IBAction func tryLogIn(_ sender: Any) {
        
        //MARK:- Handle Null
        if idTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            makeAlert(withTitle: "입력 오류", withDetai: "아이디 또는 패스워드가 입력되지 않았습니다.")
            return
        }
        
        //MARK:- Send Request to the server with id/pw
        
    
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK:- Helper Functions
    func initialViewSetting(){
        okButton.backgroundColor = .white
        okButton.layer.cornerRadius = 8
        motherStackView.setCustomSpacing(15, after: identificationStackView)
        motherStackView.setCustomSpacing(50, after: findPasswordButtonStackView)
        idTextField.attributedPlaceholder = NSAttributedString(string: "UserID", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    
    func makeAlert(withTitle title : String, withDetai detaill : String){
        let alert = UIAlertController(title:title , message: detaill, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default){_ in
            alert.removeFromParent()
        }
        alert.addAction( action )
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- End of VC
}

