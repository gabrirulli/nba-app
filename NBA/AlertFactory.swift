import UIKit

class AlertFactory {
    static func errorAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Errore", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        return alert
    }
}
