
import UIKit
import AVFoundation

protocol ManageGuestDelegate: class {
    func saveGuest(guest: Guest)
}

class ManageGuestTableVC: UITableViewController, CountryChooserDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var guest: Guest?
    var country: Country?
    weak var manageGuestDelegate:ManageGuestDelegate?
  
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var phonenumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var otherTextField: UITextField!
    @IBOutlet weak var flagcountryImageView: UIImageView!
    @IBOutlet weak var chosenphotoImageView: UIImageView!
    @IBOutlet weak var attachphotoLabel: UILabel!
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func choosephotoButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.view.tintColor = UIColor.darkGray
//        let status = AVCaptureDevice .authorizationStatus(forMediaType: AVMediaType.video)
//        if UIImagePickerController.isSourceTypeAvailable(.camera){
//            actionSheet.addAction(UIAlertAction (title: "Camera", style: .default, handler: { (action:UIAlertAction) in
//            imagePickerController.sourceType = .camera
//            imagePickerController.allowsEditing = false
//            self.present(imagePickerController, animated: true, completion: nil)
//            }))
//            if(status == AVAuthorizationStatus.denied) {
//                showAlertForCamera(title: "Allow access to the camera", message: "camera enable", viewController: self)
//        }
//        }
        actionSheet.addAction(UIAlertAction (title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction (title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
  
    func validateForm(){
        if let email = emailTextField.text {
            if email.isEmpty {
                showAlert(title: "Email field is empty", message: "Try Again", viewController: self)
            }
            else if (!email.isValidEmail()){
                showAlert(title: "Invalid email address", message: "Try Again", viewController: self)
            }
        }
        if let phone = phonenumberTextField.text {
            if phone.isEmpty {
               showAlert(title: "Phone field is empty", message: "Try Again", viewController: self)
            }
            else if(!phone.isValidPhone()) {
                showAlert(title: "Invalid phone number", message: "Try Again", viewController: self)
            }
        }
    }
    
    @IBAction func saveGuest(_ sender: Any) {
        if (guest == nil) {
            guest = Guest.init(id: 4, firstname: firstnameTextField.text!, lastname: lastnameTextField.text!,country: countryTextField.text!, city: cityTextField.text!, phone: phonenumberTextField.text!, email: emailTextField.text!)
            validateForm()
        } else {
            guest?.updateGuest(firstname: firstnameTextField.text!, lastname: lastnameTextField.text!, country: countryTextField.text!, city: cityTextField.text!, phone: phonenumberTextField.text!, email: emailTextField.text!)
            validateForm()
        }
        
        manageGuestDelegate?.saveGuest(guest: guest!)
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "detailsToListCountry", sender: self)
    }

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailsToListCountry") {
            let chooseController = segue.destination as! ChooseCountryVC
            chooseController.countrychoserDelegate = self
        }
    }
    
    func choosedCountry(country: Country) {
        countryTextField.text = country.name
        flagcountryImageView.image = country.image
    }
    
    func fillFormData() {
        if let g = guest {
            firstnameTextField.text = g.firstname
            lastnameTextField.text = g.lastname
            countryTextField.text = g.country
            cityTextField.text = g.city
            phonenumberTextField.text = g.phone
            emailTextField.text = g.email
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillFormData()
    }
}
extension ManageGuestTableVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        chosenphotoImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

