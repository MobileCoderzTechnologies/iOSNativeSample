

import GoogleSignIn

protocol SocialSignDelegate: AnyObject {
    func user(data: [String: String])
}

class GoogleLoginManager: NSObject {
    let configuration: GIDConfiguration?
    weak var delegate: SocialSignDelegate?
    
    init(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
         configuration = GIDConfiguration.init(clientID: "3h24gcrb2783rytcb23urygc3uirhgcinouh4riul24nhircn2rilu2h4rnci2glrh")
    }
    
    func loginWithGooglePlus(controller: UIViewController) {
        guard let config = configuration else{
            DisplayBanner.show(title: "Error in configuration.")
            return
        }
        GIDSignIn.sharedInstance.signIn(with: config, presenting: controller) { [weak self] user, error in
            
            guard let user  = user, let userId = user.userID else{
                DisplayBanner.show(title: error?.localizedDescription)
                return
            }
            var params = [String: String]()
            params["social_id"] = userId
            if let name = user.profile?.name {
                params["name"] = name
            }
            if let email = user.profile?.email {
                params["email"] = email
            }
            if user.profile?.hasImage ?? false{
                if let imageUrl = user.profile?.imageURL(withDimension: 120) {
                    params["image"] =  "\(imageUrl)"
                }
            }
            self?.delegate?.user(data: params)
        }
    }
    
    func logout() {
        GIDSignIn.sharedInstance.signOut()
    }
}

