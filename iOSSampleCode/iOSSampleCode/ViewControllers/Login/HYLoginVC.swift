//
//  HYLoginVC.swift
//  Hyred
//
//  Created by Mobilecoderz1 on 24/05/21.
//

import UIKit

class HYLoginVC: UIViewController {
    @IBOutlet weak var labelWelcomeHeader: UILabel!
    @IBOutlet weak var labelAccessHeader: UILabel!
    @IBOutlet weak var labelLoginHeader: UILabel!
    @IBOutlet weak var labelDontHaveAccount: UILabel!
    @IBOutlet weak var labelContinue: UILabel!
    @IBOutlet weak var buttonRememberMe: UIButton!
    @IBOutlet weak var buttonForgotPassword: UIButton!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var buttonFacebook: UIButton!
    @IBOutlet weak var buttonLinkedin: UIButton!
    @IBOutlet weak var buttonApple: UIButton!
    @IBOutlet weak var buttonSignup: UIButton!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    let appleLoginManager = AppleLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
    }
    func setupAppearance(){
        labelContinue.style(fontType: .regular, fontSize: .size12, textColor: Color.appTitle, backgroundColor: Color.appWhite)
        labelWelcomeHeader.style(fontType: .bold, fontSize: .size24, textColor: Color.appDarkBlue)
        labelAccessHeader.style(fontType: .regular, fontSize: .size15, textColor: Color.appTitle, textStyle: .subheadline)
        labelLoginHeader.style(fontType: .bold, fontSize: .size18, textColor: Color.appDarkBlue, textStyle: .body)
        textFieldEmail.style(fontType: .regular, fontSize: .size14, textColor: Color.appDarkBlue, textStyle: .subheadline, placeholderColor: Color.appTitle)
        textFieldPassword.style(fontType: .regular, fontSize: .size14, textColor: Color.appDarkBlue, textStyle: .subheadline, placeholderColor: Color.appTitle)
        textFieldEmail.setLeftView(imageName: "email")
        textFieldPassword.setLeftView(imageName: "lock")
        //textFieldPassword.setRightView(imageName: "eye")
        textFieldPassword.setRightButtonWithImage(active: "eye-active", inactive: "eye")
        textFieldPassword.isSecureTextEntry = true
        textFieldEmail.borderStyle = .none
        textFieldPassword.borderStyle = .none
        textFieldEmail.setRadius(10, Color.appDarkBlue, 1)
        textFieldPassword.setRadius(10, Color.appDarkBlue, 1)
        buttonRememberMe.style(fontType: .regular, fontSize: .size14, textColor: Color.appTitle, textStyle: .subheadline)
        buttonForgotPassword.style(fontType: .regular, fontSize: .size14, textColor: Color.appTitle, textStyle: .subheadline)
        buttonSubmit.style(fontType: .bold, fontSize: .size16, textColor: Color.appWhite, textStyle: .callout, backgroundColor: Color.appDarkBlue)
        buttonSubmit.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        labelDontHaveAccount.style(fontType: .regular, fontSize: .size15, textColor: Color.appTitle, textStyle: .subheadline)
        buttonSignup.style(fontType: .bold, fontSize: .size15, textColor: Color.appDarkBlue, textStyle: .subheadline)
        buttonSignup.underline()
        textFieldEmail.keyboardType = .emailAddress
        if #available(iOS 13, *) {
            buttonApple.isHidden = false
        }else{
            buttonApple.isHidden = true
        }
        
        textFieldEmail.returnKeyType = .done
        textFieldPassword.returnKeyType = .done
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        
    }
    func setButtonStype(button: UIButton){
        button.contentHorizontalAlignment = .left
        button.setRadius(buttonFacebook.frame.height/2, Color.appTitle, 1)
        button.style(fontType: .regular, fontSize: .size14, textColor: Color.appTitle, textStyle: .subheadline)
        button.contentEdgeInsets = UIEdgeInsets(top: 13, left: 20, bottom: 13, right:20)
        let imageWidth = button.imageView?.frame.width ?? 0
        let titleWidth = button.titleLabel?.frame.width ?? 0
        let buttonWidth = button.frame.width
        let inset = (buttonWidth - titleWidth) / 2
        button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: inset - imageWidth - 20, bottom: 0.0, right: 0.0)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonSubmit.setRadius(buttonSubmit.frame.height / 2)
        [buttonApple, buttonLinkedin, buttonFacebook].forEach { [weak self] (button) in
            self?.setButtonStype(button: button)
        }
    }
}


extension HYLoginVC :UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textFieldEmail.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        return true
    }
}
