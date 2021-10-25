
import UIKit
extension UIButton{
    func style(fontType: FontType, fontSize: FontSize, textColor: UIColor, textStyle: UIFont.TextStyle? = nil, isDynamic: Bool = true, backgroundColor: UIColor = .clear){
        if isDynamic{
            titleLabel?.adjustsFontForContentSizeCategory = true
            titleLabel?.font = DynamicFont.font(type: fontType, size: fontSize, textStyle: textStyle)
        }else{
            titleLabel?.font = StaticFont.font(type: fontType, size: fontSize)
            
        }
        setTitleColor(textColor, for: .normal)
        setTitleColor(textColor, for: .selected)

        self.backgroundColor = backgroundColor
        
    }
    func underline() {
        guard let text = title(for: .normal), let titleColor = titleColor(for: .normal), let font = titleLabel?.font else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: titleColor, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: titleColor, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
