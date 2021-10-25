

import UIKit
extension UITextField{
    func style(fontType: FontType, fontSize: FontSize, textColor: UIColor, textStyle: UIFont.TextStyle? = nil, isDynamic: Bool = true, backgroundColor: UIColor = .clear, placeholderColor: UIColor){
        if isDynamic{
            adjustsFontForContentSizeCategory = true
            font = DynamicFont.font(type: fontType, size: fontSize, textStyle: textStyle)
        }else{
            font = StaticFont.font(type: fontType, size: fontSize)
            
        }
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        if let placeholder = placeholder{
        setAttributedPlaceholder(placeHolder: placeholder, color: placeholderColor, font: font)
        }
        
    }
}
