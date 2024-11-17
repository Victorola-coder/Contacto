


import UIKit

protocol ExistingContactViewControllerDelegate: AnyObject {
    func existingContactViewController(_ viewController: ExistingContactViewController,
                                     didEditContact contact: Contact)
}

class ExistingContactViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var contact: Contact!
    weak var delegate: ExistingContactViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up navigation bar
        navigationItem.title = "Edit Contact"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveContact)
        )
        
        // Populate text fields with existing contact info
        nameTextField.text = contact.name
        phoneNumberTextField.text = contact.phoneNumber
    }
    
    @objc func saveContact() {
        guard let name = nameTextField.text, !name.isEmpty,
              let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            // Show alert if fields are empty
            let alert = UIAlertController(
                title: "Invalid Input",
                message: "Name and phone number cannot be empty",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        // Update contact information
        contact.name = name
        contact.phoneNumber = phoneNumber
        
        // Notify delegate about the changes
        delegate?.existingContactViewController(self, didEditContact: contact)
        
        // Dismiss the view controller
        navigationController?.popViewController(animated: true)
    }
}
