
import UIKit
extension UILabel{
    func style(fontType: FontType, fontSize: FontSize, textColor: UIColor, textStyle: UIFont.TextStyle? = nil, isDynamic: Bool = true, backgroundColor: UIColor = .clear){
        if isDynamic{
            adjustsFontForContentSizeCategory = true
            font = DynamicFont.font(type: fontType, size: fontSize, textStyle: textStyle)
        }else{
            font = StaticFont.font(type: fontType, size: fontSize)
            
        }
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        
    }
    func setAttributedTextForAsteric(color: UIColor){
        guard let textString = text, let font = font else{return}
        let range = (textString as NSString).range(of: "*")
        let attributedString = NSMutableAttributedString(string:textString)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        attributedString.addAttribute(NSAttributedString.Key.font, value: font , range: range)
        self.attributedText = attributedString
    }
}



class CustomTextField: UITextField{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    let padding = UIEdgeInsets(top: 15, left: 40, bottom: 15, right: 40)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

class CustomPaddingTextField: UITextField{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    let padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
class CustomDropDownTextField: UITextField{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    let padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 40)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
class CustomLeftPaddingTextField: UITextField{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    let padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 40)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
class CustomInfoTextField: UITextField{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    let padding = UIEdgeInsets(top: 15, left: 25, bottom: 15, right: 20)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
class CustomVerificationTextField: UITextField{
    var customDelegate: EmptyDelegate?
    override public func deleteBackward() {
        if text == "" {
            customDelegate?.empty(field: self)
        }
        super.deleteBackward()
    }
}

class CustomExpandButton: UIButton{
    override func layoutSubviews() {
        super.layoutSubviews()
       // self.titleLabel?.preferredMaxLayoutWidth = self.titleLabel?.frame.size.width ?? 0
    }

    override var intrinsicContentSize: CGSize {
        //return self.titleLabel?.intrinsicContentSize ?? CGSize.zero
        return CGSize(width: frame.size.width, height: titleLabel?.frame.size.height ?? 0.0);

    }
}
