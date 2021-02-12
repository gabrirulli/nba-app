import UIKit

class AlertFactory {
    static func errorAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Errore", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        return alert
    }
    
    static func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Caricamento...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.color = UIColor.black
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        
        return alert
    }
}
