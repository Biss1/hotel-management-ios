
import Foundation
import UIKit

func showAlert(title: String, message: String, viewController: UIViewController) {
    let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    viewController.present(alertView, animated: true, completion: nil)
}
func showAlertForCamera(title:String, message:String, viewController: UIViewController){
    let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertView.addAction(UIAlertAction (title: "Cancel", style: .cancel, handler: nil))
    alertView.addAction(UIAlertAction (title: "Go to settings", style: .default, handler: { (action: UIAlertAction) in
        UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)
    }))
    viewController.present(alertView, animated: true, completion: nil)
}
