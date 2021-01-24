//
//  FindPasswordViewController.swift
//  TravelTest2
//
//  Created by 한석희 on 1/19/21.
//

import UIKit
import Foundation

class FindPasswordViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK:-Outlets
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var whiteBar: UIView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    //MARK:- Ins Vars
    var successAlertDone = false
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetting()
        //
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        //
    }
    //
    //
    @IBAction func tryFindPassword(_ sender: Any) {
        //
        buttonPressUIConfigure()
        //
        if userIDTextField.text!.isEmpty {
            return
        }
        //
        ApiMananger.sharedInstance.callingResetLoginAPI(id: userIDTextField.text!){ [self] success, failureCode in
            //
            if success == true {
                successAlertDone = true
                makeAlert(withTitle: "알림", withDetai: "새로 발급된 비밀번호를 등록하신 이메일로 전송하였습니다.")
                return
            }
            //
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
        //MARK:- End of button action
    }

    
    
    
    
    //MARK:- Helper Function
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
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
    
}
