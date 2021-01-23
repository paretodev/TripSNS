//
//  LogInViewController.swift
//  TravelTest2
//
//  Created by 한석희 on 1/13/21.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    
    //MARK:- For Layout
    @IBOutlet weak var motherStackView: UIStackView!
    @IBOutlet weak var identificationStackView: UIStackView!
//    @IBOutlet weak var findPasswordButtonStackView: UIStackView!
    //MARK:- OK button
    @IBOutlet weak var okButton: UIButton!
    //MARK:- Text Fields
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextfield: UITextField!
    //MARK:- Action Back Button Action
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    var isRegisterSuccessful = false
    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func emailTextField(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetting()
    }

//MARK:- Action Function
    @IBAction func tryRegister(_ sender: Any) {
        
        //MARK:- Handle Null
        if idTextField.text!.isEmpty || passwordTextField.text!.isEmpty ||  passwordConfirmTextfield.text!.isEmpty || emailTextField.text!.isEmpty  {
            makeAlert(withTitle: "입력 오류", withDetai: "네 가지 항목 중 비어있는 항목이 있습니다. 모두 입력해야 회원가입이 가능합니다 : ) ")
            return
        }
        
        //MARK:- Check Email Format
        if !validateEmail( candidate: emailTextField.text! ){
            makeAlert(withTitle: "이메일 오류", withDetai: "유효한 이메일 형식이 아닙니다. 다시 입력해주세요.")
            return
        }
        
        //MARK:- PasswordConfirm Check
        if passwordTextField.text! != passwordConfirmTextfield.text {
            makeAlert(withTitle: "입력 오류", withDetai: "비밀 번호와 비밀 번호 확인에 입력해주신 문자가 일치하기 않습니다.")
        }
        
        //MARK:- Send Request to the server with id/pw
        let id = idTextField.text!
        let password = passwordTextField.text!
        let email = emailTextField.text!
        let registerModel = RegisterModel(id: id, password: password, email : email )
        ApiMananger.sharedInstance.callingRegisterAPI(register: registerModel){ [weak self]
            ( isSuccess, jsonMsg ) in
            //MARK:- 성공
            if isSuccess {
                self?.isRegisterSuccessful = true
                self?.makeAlert(withTitle: "등록 완료", withDetai: "성공적으로 등록 되었습니다.")
            }
            //MARK:- 이미 등록된 아이디
            else{
                if let jsonMsg = jsonMsg {
                    if jsonMsg.contains("User already exists."){
                        self?.makeAlert(withTitle: "등록 불가", withDetai: "이미 등록된 아이디 입니다.")
                        return
                    }
                }
                //MARK: - 기타 등록 실패
                self?.makeAlert(withTitle: "등록 실패", withDetai: "회원 가입을 다시 시도해주세요.")
            }
        }
        
        //
    }
    
    
    //MARK:- Helper Functions
    func initialViewSetting(){
        //
        okButton.backgroundColor = .white
        okButton.layer.cornerRadius = 9.5
        //
        motherStackView.setCustomSpacing(25, after: identificationStackView)
        //
        idTextField.attributedPlaceholder = NSAttributedString(string: "UserID", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        passwordConfirmTextfield.attributedPlaceholder = NSAttributedString(string: "Password Confirm", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        //
    }
    
    func makeAlert(withTitle title : String, withDetai detaill : String){
        let alert = UIAlertController(title:title , message: detaill, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default){_ in
            alert.removeFromParent()
            if self.isRegisterSuccessful == true {
                self.navigationController?.popViewController(animated: true)
            }
        }
        alert.addAction( action )
        self.present(alert, animated: true, completion: nil)
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    //MARK:- End of VC
}

