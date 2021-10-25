

class Loader {

    class func show(isInteractive: Bool = false, message: String = "") {
        SKActivityIndicator.spinnerStyle(.spinningCircle)
        SKActivityIndicator.spinnerColor(Color.appDarkBlue)
        SKActivityIndicator.show(message, userInteractionStatus: isInteractive)
    }
    class func hide() {
        SKActivityIndicator.dismiss()
    }
 
}
