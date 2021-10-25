

import UIKit
extension HYSettingVC: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sectionData[section].rows.count

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(HYSettingTableCell.self, for: indexPath)
        let row = sectionData[indexPath.section].rows[indexPath.row]
        cell.labelName.text = row.name
        cell.buttonRight.setImage(UIImage(named: "right-arrow"), for: .normal)
        cell.buttonRight.setImage(UIImage(named: "right-arrow"), for: .selected)
        cell.imageViewIcon.image = UIImage(named: row.imageName)
        cell.labelDetail.isHidden = true
        cell.buttonRight.isHidden = true
        cell.buttonRight.removeTarget(self, action: #selector(buttonNotificationTapped(_:)), for: .touchUpInside)
        switch row.type {
        case .changeAccount(let type):
            cell.labelDetail.text = type
            cell.labelDetail.isHidden = false
        case .changePassword, .termsOfServices, .privacyPolicy, .inviteFriends, .rateOurApp, .deleteAccount:
            break
        case .pushNotifications(let status):
            cell.buttonRight.setImage(UIImage(named: "push-off"), for: .normal)
            cell.buttonRight.setImage(UIImage(named: "push-on"), for: .selected)
            cell.buttonRight.isSelected = status
            cell.buttonRight.addTarget(self, action: #selector(buttonNotificationTapped(_:)), for: .touchUpInside)
            cell.buttonRight.isHidden = false

        case .appVersion(version: let version):
            cell.labelDetail.isHidden = false
            cell.labelDetail.text = version

        }
        cell.buttonRight.backgroundColor = .green
        return cell
    }
    @objc func buttonNotificationTapped(_ sender: UIButton){
        sender.isSelected.toggle()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let data = sectionData[section]
        if data.name == nil{
            return nil
        }
        let view = tableView.dequeueReusableHeaderFooterCell(HYSectionTableViewHeaderFooterView.self)
        view.labelHeader.text = data.name
        view.viewTopLine.isHidden = true
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let data = sectionData[section]
        if data.name == nil{
            return CGFloat.leastNormalMagnitude
        }else{
            return UITableView.automaticDimension
        }
    }

  
    
  
}

extension HYSettingVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sectionData[indexPath.section].rows[indexPath.row]
        switchToScreen(type: row.type)
    }
    
   
}
