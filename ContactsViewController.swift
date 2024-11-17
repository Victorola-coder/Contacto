


import UIKit

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ExistingContactViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Set up navigation bar
        navigationItem.title = "Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewContact)
        )
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = contact.name
        cell.detailTextLabel?.text = contact.phoneNumber
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let existingContactVC = storyboard.instantiateViewController(
            withIdentifier: "ExistingContactViewController"
        ) as? ExistingContactViewController else {
            return
        }
        
        existingContactVC.contact = contact
        existingContactVC.delegate = self
        
        navigationController?.pushViewController(existingContactVC, animated: true)
    }
    
    // MARK: - ExistingContactViewControllerDelegate
    
    func existingContactViewController(_ viewController: ExistingContactViewController,
                                     didEditContact contact: Contact) {
        // Find and update the contact in the array
        if let index = contacts.firstIndex(where: { $0 === contact }) {
            contacts[index] = contact
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
    
    // MARK: - Actions
    
    @objc func addNewContact() {
        // Implementation for adding new contact
    }
    
    
}
