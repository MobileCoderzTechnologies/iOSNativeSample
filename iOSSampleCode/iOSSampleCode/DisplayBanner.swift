

import BRYXBanner
class DisplayBanner {
    class  func show(title:String?, subtitle: String? = nil, duration: Double = 3.2) {
        guard let title = title, !title.isEmpty else {
            return
        }
        let banner = Banner(title: title.localized() , subtitle: subtitle, image: nil, backgroundColor: Color.appDarkBlue)
        banner.dismissesOnTap = true
        banner.show(duration: duration)
        Console.log("DisplayBanner :- \(title)")
    }
}
