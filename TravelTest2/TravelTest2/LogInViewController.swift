//
//  LogInViewController.swift
//  TravelTest2
//
//  Created by 한석희 on 1/13/21.
//

import UIKit
import Alamofire

class LogInViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var motherStackView: UIStackView!
    @IBOutlet weak var identificationStackView: UIStackView!
    @IBOutlet weak var idStackView: UIStackView!
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var findPasswordButtonStackView: UIStackView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var noInputInID: UILabel!
    @IBOutlet weak var noInputInPassword: UILabel!
    @IBOutlet weak var idBar: UIView!
    @IBOutlet weak var passwordBar: UIView!
    
    //MARK:- Ins Vars
    var userToken = ""
    var objectID = ""
    var updatedLoginStatus = false
    
    //MARK:- Outlet Action
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetting()
    }
    
    //MARK:- Main Actions
    @IBAction func tryLogin(_ sender: Any) {
        //
        configureTextfieldUIToEmptiness()
        handleEmptyTextFieldsWithAlert()
        //
        let id = idTextField.text!
        let password = passwordTextField.text!
        let modelLogin = LoginModel(login: id, password: password)
        ApiMananger.sharedInstance.callingLoginAPI(login: modelLogin){ [self] (result) in
            switch result{
                case .success(let json) :
                    handleLoginSuccess(usingJson: json)
                case .failure(let error):
                    if case .custom(let value) = error {
                        makeAlertOn(errorType: value)
                    }
            }
        }
        //MARK:- End of Try Login Button Action
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ServiceMainSegue" {
            print("Prepare Segue From Log in Done !!")
            let controller =  ( segue.destination as! ServiceMainViewController )
            controller.userToken = self.userToken
            controller.objectID = self.objectID
        }
    }
    
    
    //MARK:- Helper Functions
        //
    func initialViewSetting(){
        okButton.backgroundColor = .white
        okButton.layer.cornerRadius = 8
        motherStackView.setCustomSpacing(1, after: identificationStackView)
        motherStackView.setCustomSpacing(50, after: findPasswordButtonStackView)
        identificationStackView.setCustomSpacing(4, after: idStackView)
        identificationStackView.setCustomSpacing(15, after: noInputInID)
        identificationStackView.setCustomSpacing(4, after: passwordStackView)
        idTextField.attributedPlaceholder = NSAttributedString(string: "UserID", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        noInputInID.textColor = UIColor(named: "nBlue")
        noInputInPassword.textColor = UIColor(named: "nBlue")
    }
        //
    func makeAlert(withTitle title : String, withDetai detaill : String){
        let alert = UIAlertController(title:title , message: detaill, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default){_ in
            //MARK: - Handle here !!
            if self.updatedLoginStatus == true {
                self.updatedLoginStatus = false
                self.performSegue(withIdentifier: "ServiceMainSegue", sender: nil)
            }
        }
        alert.addAction( action )
        self.present(alert, animated: true, completion: nil)
    }
        //
    func configureTextfieldUIToEmptiness() {
        if ( idTextField.text!.isEmpty ) && ( passwordTextField.text!.isEmpty) {
            noInputInID.textColor = UIColor.systemRed
            noInputInPassword.textColor = UIColor.systemRed
            idBar.backgroundColor = UIColor.systemRed
            passwordBar.backgroundColor = UIColor.systemRed
            idTextField.attributedPlaceholder = NSAttributedString(string: "UserID", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
        }
        else if ( idTextField.text!.isEmpty ){
            noInputInID.textColor = UIColor.systemRed
            noInputInPassword.textColor = UIColor(named: "nBlue")
            idTextField.attributedPlaceholder = NSAttributedString(string: "UserID", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            idBar.backgroundColor = UIColor.systemRed
            passwordBar.backgroundColor = UIColor.white
        }
        else if (passwordTextField.text!.isEmpty){
            noInputInPassword.textColor = UIColor.systemRed
            noInputInID.textColor = UIColor(named: "nBlue")
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            passwordBar.backgroundColor = UIColor.systemRed
            idBar.backgroundColor = UIColor.white
        }
        else {
            noInputInPassword.textColor = UIColor(named: "nBlue")
            noInputInID.textColor = UIColor(named: "nBlue")
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            idTextField.attributedPlaceholder = NSAttributedString(string: "UserID", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            idBar.backgroundColor = .white
            passwordBar.backgroundColor = .white
        }
    }
        //
    func handleEmptyTextFieldsWithAlert(){
        if ( idTextField.text!.isEmpty ) || ( passwordTextField.text!.isEmpty) {
            makeAlert(withTitle: "입력 오류", withDetai: "아이디, 비밀 번호를 모두 입력해주시기 바랍니다.")
            return
        }
    }
        //
    func makeAlertOn(errorType value: String){
        
        if value == "IPE" {
            self.makeAlert(withTitle: "알림", withDetai: "아이디 또는 비밀번호가 일치하지 않습니다.")
        }
        
        else if value == "NI" {
            self.makeAlert(withTitle: "알림", withDetai: "인터넷이 연결되어 있지 않습니다. 로그인하려면 네트워크를 연결해주세요.")
        }
        
        else if value == "ETCLE" {
            self.makeAlert(withTitle: "알림", withDetai: "기타 로그인 에러")
        }
        
        else if value == "NP" {
            self.makeAlert(withTitle: "알림", withDetai: "서비스에 오류가 발생하였습니다. 빠르게 해결하겠습니다.")
        }
        
    }
        //
    func handleLoginSuccess(usingJson json : Any?){
        
        let id = (json as! LoginResponseModel).id
        self.userToken = ( json as! LoginResponseModel ).userToken
        self.objectID = ( json as! LoginResponseModel ).objectID
        UserDefaults.standard.set(self.userToken, forKey: "UserToken")
        UserDefaults.standard.set(self.objectID, forKey: "ObjectID")
        self.updatedLoginStatus = true
        self.makeAlert(withTitle: "로그인 완료", withDetai: "\(id)로 로그인 되었습니다.")
        
    }
    
    //MARK:- End of VC
}


