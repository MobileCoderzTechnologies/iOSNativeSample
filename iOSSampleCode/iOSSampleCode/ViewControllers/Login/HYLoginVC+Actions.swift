
import UIKit

extension HYLoginVC{
    
    @IBAction func buttonSubmitTapped(_ sender: UIButton){
        var params = [String: Any]()
        let validateEmail = String.checkForEmailValidationErrorMessage(value: textFieldEmail.text)
        if let message = validateEmail.message{
            return DisplayBanner.show(title: message)
        }
        guard let email = validateEmail.value else {
            return DisplayBanner.show(title: ErrorMessages.shouldNotHappen)
        }
        params["email"] = email
        
        let validatePassword = String.checkForPasswordValidationErrorMessage(value: textFieldPassword.text)
        if let message = validatePassword.message{
            return DisplayBanner.show(title: message)
        }
        guard let password = validatePassword.value else {
            return DisplayBanner.show(title: ErrorMessages.shouldNotHappen)
        }
        params["password"] = password
        view.endEditing(true)
        login(params: params, email: email)
    }
    @IBAction func buttonSignupTapped(_ sender: UIButton){
        let vc = HYSignupVC.instantiate(fromAppStoryboard: .registration)
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func buttonFacebookTapped(_ sender: UIButton){
        kAppDelegate.facebookLoginManager?.loginWithFacebook(viewController: self)
        kAppDelegate.facebookLoginManager?.delegate = self
//        let vc = HYAccountVerificationVC.instantiate(fromAppStoryboard: .registration)
//        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func buttonGoogleTapped(_ sender: UIButton){
        kAppDelegate.googlePlusHandler?.loginWithGooglePlus(controller: self)
        kAppDelegate.googlePlusHandler?.delegate = self
    }

    @IBAction func buttonForgotPasswordTapped(_ sender: UIButton){
        let vc = HYForgotPasswordVC.instantiate(fromAppStoryboard: .registration)
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func buttonRemeberMeTapped(_ sender: UIButton){
        sender.isSelected.toggle()
       // let vc = HYReviewProfileVC.instantiate(fromAppStoryboard: .profile)
       // navigationController?.pushViewController(vc, animated: true)
    }
}
extension HYLoginVC: SocialSignDelegate{
 
    func user(data: [String : String]) {
        
        print("HYLoginVC \(data)")
        
        socialLogin(params:data, email: textFieldEmail.text ?? "")
    }
    
}
