

import UIKit
enum SettingOptions{
    case changeAccount(type: String)
    case changePassword
    case inviteFriends
    case rateOurApp
    case pushNotifications(status: Bool)
    case deleteAccount
    case appVersion(version: String)
    case privacyPolicy
    case termsOfServices
}
struct SettingModel {
    let name: String
    let imageName: String
    let type: SettingOptions
}
struct SettingSection {
    let name: String?
    let rows: [SettingModel]
}
class HYSettingVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonLogout: UIButton!
    var sectionData = [SettingSection]()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
        setupNavigationBar()
        setupData()
        setupTableView()

    }
    func setupAppearance(){
        buttonLogout.style(fontType: .bold, fontSize: .size16, textColor: Color.appWhite, textStyle: .callout, backgroundColor: Color.appDarkBlue)

        buttonLogout.contentEdgeInsets = UIEdgeInsets(top: 15, left: 50, bottom: 15, right: 50)

    }
    func setupData(){
        let model1 = SettingModel(name: "Change Account Type", imageName: "user", type: .changeAccount(type: "Free"))
        let model2 = SettingModel(name: "Change Password", imageName: "change-password", type: .changePassword)
        let model3 = SettingModel(name: "Invite Friends", imageName: "invite", type: .inviteFriends)
        let model4 = SettingModel(name: "Rate Our App", imageName: "rate-app", type: .rateOurApp)
        let section1 = SettingSection(name: nil, rows: [model1, model2, model3, model4])
        
        let model5 = SettingModel(name: "Push Notifications", imageName: "notification-icon", type: .pushNotifications(status: false))
        let model6 = SettingModel(name: "Delete Account", imageName: "delete-account", type: .deleteAccount)
        let version = Bundle.main.releaseVersionNumber ?? "0.0.0"
        let model7 = SettingModel(name: "App Version", imageName: "app-version", type: .appVersion(version: version))

        let model8 = SettingModel(name: "Privacy Policy", imageName: "privacy-policy", type: .privacyPolicy)
        let model9 = SettingModel(name: "Terms of Services", imageName: "terms-of-services", type: .termsOfServices)
        let section2 = SettingSection(name: "SUPPORT", rows: [model5, model6, model7, model8, model9])
        sectionData.append(section1)
        sectionData.append(section2)



    }
    func setupNavigationBar(){
        navigationItem.title = "Settings"
        setRightBarButtonItem(imageName: "notification")
        navigationItem.rightBarButtonItem?.action = #selector(buttonNotificationIconTapped)
    }
    @objc func buttonNotificationIconTapped(){
        let vc = HYNotificationVC.instantiate(fromAppStoryboard: .registration)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    func setupTableView(){
        tableView.registerReusableCell(HYSettingTableCell.self)
        tableView.registerReusableHeaderFooterCell(HYSectionTableViewHeaderFooterView.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 100
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            buttonLogout.setRadius(buttonLogout.frame.height / 2)
    }
    
    func switchToScreen(type: SettingOptions){
        switch type {
     
        case .changeAccount(type: let type):
            switchToSubscriptionScreen()
        case .changePassword:
            switchToChangePassword()
        case .inviteFriends:
            break
        case .rateOurApp:
            break
        case .pushNotifications(status: let status):
            break
        case .deleteAccount:
            switchToDeleteAccount()
        case .appVersion:
            break
        case .privacyPolicy:
            switchToWebview(type: .privacyPolicy)
        case .termsOfServices:
            switchToWebview(type: .termOfService)
        }
    }
    func switchToSubscriptionScreen(){
        let vc = HYSubscriptionVC.instantiate(fromAppStoryboard: .registration)
        navigationController?.pushViewController(vc, animated: true)
    }
    func switchToWebview(type: WebViewType){
        let vc = HYWebViewVC.instantiate(fromAppStoryboard: .setting)
        vc.webViewType = type
        navigationController?.pushViewController(vc, animated: true)
    }
    func switchToChangePassword(){
        let vc = HYChangePasswordVC.instantiate(fromAppStoryboard: .setting)
        navigationController?.pushViewController(vc, animated: true)
    }
    func switchToDeleteAccount(){
        let vc = HYAlertVC.instantiate(fromAppStoryboard: .alert)
        vc.currentAlertType = .deleteAccount
        tabBarController?.present(vc, animated: true, completion: nil)
    }
    @IBAction func buttonLogoutTapped(_sender: UIButton){
        let vc = HYAlertVC.instantiate(fromAppStoryboard: .alert)
        vc.currentAlertType = .logout
        vc.delegate = self
        tabBarController?.present(vc, animated: true, completion: nil)
    }
}
extension HYSettingVC: AlertDismissDelegate{
    func alertDismissed(type: AlertType, value: Any?) {
        if type == .logout || type == .deleteAccount{
            kAppDelegate.removeSavedData()
            let loginVC = HYLoginVC.instantiate(fromAppStoryboard: .registration)
            let nav = SwipeableNavigationController(rootViewController: loginVC)
            nav.setNavigationBarHidden(true, animated: false)
            kAppDelegate.window?.rootViewController = nav
        }
    }
    
    
}
