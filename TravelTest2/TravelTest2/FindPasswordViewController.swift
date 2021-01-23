//
//  FindPasswordViewController.swift
//  TravelTest2
//
//  Created by 한석희 on 1/19/21.
//

import UIKit
import Foundation

class FindPasswordViewController: UIViewController {
    
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var whiteBar: UIView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    var successAlertDone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetting()

    }
    
    @IBAction func tryFindPassword(_ sender: Any) {
        //
        if userIDTextField.text!.isEmpty {
            buttonPressUIConfigure()
            return
        }
        
        //
        buttonPressUIConfigure()
        //MARK:- 비밀번호 찾기 요청을 보낸다 -> Email로 비밀 번호를 보내준다 !! -> 메이크 센스
        ApiMananger.sharedInstance.callingResetLoginAPI(id: userIDTextField.text!){ [self] success, failureCode in
            
            if success == true {
                successAlertDone = true
                makeAlert(withTitle: "알림", withDetai: "새로 발급된 비밀번호를 등록하신 이메일로 전송하였습니다.")
                return
            }
            
            switch failureCode {
                case "UNF":
                    makeAlert(withTitle: "알림", withDetai: "등록되지 않은 아이디 입니다.")
                case "UNK":
                    makeAlert(withTitle: "오류", withDetai: "프로그램에 오류가 발생했습니다. 빠른 시간 내에 해결하겠습니다.")
                case "NNC":
                    makeAlert(withTitle: "오류", withDetai: "네트워크가 연결되어 있지 않거나, 아이디가 틀린 양식입니다(영문,숫자 조합)")
                default :
                    break
            }
        }
        
        
        //
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK:- Helper Function
    func initialViewSetting(){
        inputStackView.setCustomSpacing(5, after: whiteBar)
        warningLabel.textColor = UIColor(named: "nBlue")
        userIDTextField.attributedPlaceholder = NSAttributedString(string: "UserID", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        okButton.backgroundColor = .white
        okButton.layer.cornerRadius = 8
        okButton.setTitleColor(UIColor(named: "nBlue"), for: .normal)
    }
    //
    func buttonPressUIConfigure(){
    
        if userIDTextField.text!.isEmpty {
            userIDTextField.attributedPlaceholder = NSAttributedString(string: "UserID", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemRed])
            whiteBar.backgroundColor = UIColor.systemRed
            warningLabel.textColor = UIColor.systemRed
        }
        else{
            userIDTextField.attributedPlaceholder = NSAttributedString(string: "UserID", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            whiteBar.backgroundColor = .white
            warningLabel.textColor = UIColor(named: "nBlue")
        }
    
    }
    
    
    //MARK: -
    func makeAlert(withTitle title : String, withDetai detaill : String){
        let alert = UIAlertController(title:title , message: detaill, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default){_ in
            if self.successAlertDone {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        alert.addAction( action )
        self.present(alert, animated: true, completion: nil)
    }
    
//
}