

import PromiseKit

extension HYLoginVC{
    func login(params: [String: Any], email: String){
        Loader.show()
        firstly{
            service!.login(params: params)
        }.done { (model: Register) in
            self.handleResponse(model: model, email: email)
        }.catch { (error) in
            print(error)
            DisplayBanner.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
    func socialLogin(params: [String: Any],email:String){
        Loader.show()
        firstly{
            service!.socialLogin(params: params)
        }.done { (model: Register) in
            self.handleResponse(model: model, email: email)
        }.catch { (error) in
            print(error)
            DisplayBanner.show(title: error.localizedDescription)
        }.finally {
            Loader.hide()
        }
    }
   
    func handleResponse(model: Register, email: String) {
        if model.status != 200 && model.status != 201 && model.status != 400 {
            DisplayBanner.show(title: model.message)
            return
        }
        Console.log(model)
        if model.data?.token == nil{
            switchToVerification(email: email)
        }else{
            kAppDelegate.savedProfileData = model.data
            if let role = model.data?.user?.role{
                if role == "candidate"{
                    checkToSwitchScreen(data: model.data)
                    
                }else{
                  
                    checkToSwitchScreenForRecriuter(data: model.data)
                    
                   // DisplayBanner.show(title: "\(role.capitalized) can't login for now. It's Flow is under development.")
                }
                
            }else{
                
                switchToSelectRole()
            }
        }
        DisplayBanner.show(title: model.message)
    }
    func checkToSwitchScreen(data: RegisterData?){
        kAppDelegate.checkForCandidateProfileCompleted(data: data)
    }
    
    func checkToSwitchScreenForRecriuter(data: RegisterData?){
        kAppDelegate.checkForCompanyProfileScreen(data: data)
    }
    func switchToSelectRole(){
        let vc = HYAccountSelectionVC.instantiate(fromAppStoryboard: .registration)
        navigationController?.pushViewController(vc, animated: true)
    }
    func switchToVerification(email: String?){
        let vc = HYAccountVerificationVC.instantiate(fromAppStoryboard: .registration)
        vc.email = email
        navigationController?.pushViewController(vc, animated: true)
    }
}



