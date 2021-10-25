

import UIKit

extension UIFont {
    class func printFontFamily(){
        for family in UIFont.familyNames {
            print("Family \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("Members----\(name)")
            }
        }
    }

    func withTraits(traits:UIFontDescriptor.SymbolicTraits...) -> UIFont {
            let descriptor = self.fontDescriptor
                .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
            return UIFont(descriptor: descriptor!, size: 0)
        }

        func bold() -> UIFont {
            return withTraits(traits: .traitBold)
        }
    }


public func getAppropriateFontName(fromType: FontType) -> String{
    let language = AppLanguage.english
     switch language {
     case .english:
        switch fromType {
        case .regular:
            return FontName.regular
        case .regularItalic:
            return FontName.regularItalic
        case .bold:
            return FontName.bold
        case .boldItalic:
            return FontName.boldItalic
        case .light:
            return FontName.light
        case .lightItalic:
            return FontName.lightItalic
        case .medium:
            return FontName.medium
        case .mediumItalic:
            return FontName.mediumItalic
        }
      
     case .arabic:
        switch fromType {
        case .regular:
            return FontName.regular
        case .regularItalic:
            return FontName.regularItalic
        case .bold:
            return FontName.bold
        case .boldItalic:
            return FontName.boldItalic
        case .light:
            return FontName.light
        case .lightItalic:
            return FontName.lightItalic
        case .medium:
            return FontName.medium
        case .mediumItalic:
            return FontName.mediumItalic
        }
      
     case .hindi:
        switch fromType {
        case .regular:
            return FontName.regular
        case .regularItalic:
            return FontName.regularItalic
        case .bold:
            return FontName.bold
        case .boldItalic:
            return FontName.boldItalic
        case .light:
            return FontName.light
        case .lightItalic:
            return FontName.lightItalic
        case .medium:
            return FontName.medium
        case .mediumItalic:
            return FontName.mediumItalic
        }
     }
 }
public final class StaticFont{
    class func font(type: FontType, size: FontSize) -> UIFont {
        return UIFont(name: getAppropriateFontName(fromType: type), size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue)
    }

}

public final class DynamicFont{
    class func font(type: FontType, size: FontSize, textStyle: UIFont.TextStyle? = nil) -> UIFont {
        guard let font = UIFont(name: getAppropriateFontName(fromType: type), size: size.rawValue) else {return UIFont.preferredFont(forTextStyle: getStyle(size: size, textStyle: textStyle))}
        let fontMetrics = UIFontMetrics(forTextStyle: getStyle(size: size, textStyle: textStyle))
        return fontMetrics.scaledFont(for: font)
    }
    
    class func getStyle(size: FontSize, textStyle: UIFont.TextStyle?) -> UIFont.TextStyle{
        if let style = textStyle{
            return style
        }
        switch size {
      
        case .size11, .size10:
            return .caption2
        case .size12:
            return .caption1
        case .size13:
            return .footnote
        case .size14:
            return .subheadline
        case .size15:
            return .subheadline
        case .size16:
            return .callout
        case .size17:
            return .body
        case .size18:
            return .body
        case .size20:
            return .title3
        case .size22:
            return .title2
        case .size24:
            return .title1
        case .size25:
            return .title1
        case .size28:
            return .title1
        case .size30:
            return .largeTitle
      
        }
    }
 
}

public enum FontType: String{
    case regular = "regular"
    case regularItalic = "regularItalic"

    case bold = "bold"
    case boldItalic = "boldItalic"

    case light = "light"
    case lightItalic = "lightItalic"

    case medium = "medium"
    case mediumItalic = "mediumItalic"
    
}
struct FontName {
    static let regular = "Helvetica"
    static let regularItalic = "Helvetica"
    static let bold = "Helvetica-Bold"
    static let boldItalic = "Helvetica-BoldOblique"
    static let medium = "Helvetica-Oblique"
    static let mediumItalic = "HelveticaRounded-Bold"
    static let light = "Helvetica-Light"
    static let lightItalic = "Helvetica-LightOblique"


}
enum FontSize: CGFloat{
    case size10 = 10 //caption2
    case size11 = 11 //caption2
    case size12 = 12 //caption1
    case size13 = 13 //footnote
    case size14 = 14 //subheadline
    case size15 = 15 //subheadline
    case size16 = 16 //callout
    case size17 = 17 //headline, body
    case size18 = 18 //headline, body
    case size20 = 20 //title3
    case size22 = 22 //title2
    case size24 = 24 //title1
    case size25 = 25 //title1
    case size28 = 28 //title1
    case size30 = 34 //largeTitle

}
public enum AppLanguage: String {
    case english = "en"
    case arabic = "ar"
    case hindi = "hi"
}
