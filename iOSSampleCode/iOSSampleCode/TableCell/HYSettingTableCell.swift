

import UIKit

class HYSettingTableCell: UITableViewCell, Reusable {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var buttonRight: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        labelName.style(fontType: .regular, fontSize: .size15, textColor: Color.appTitle)
        labelDetail.style(fontType: .regular, fontSize: .size14, textColor: Color.appDarkBlue)
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
