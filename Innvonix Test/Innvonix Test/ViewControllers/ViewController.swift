//
//  ViewController.swift
//  Innvonix Test
//
//  Created by Anant Bhatt on 03/02/23.
//

import UIKit
import Contacts

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let store = CNContactStore()
    var dataArrayContact = [ContactData]()
    var arrContact = [ContactStruct]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    //MARK: - Function
    func fetchContacts(){
        
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        try! store.enumerateContacts(with: request) { (contact,stoppingPointer) in
            
            let name = contact.givenName
            let familyName = contact.familyName
            let num = contact.phoneNumbers.first?.value.stringValue
            
            let contactToAppend  = ContactStruct(firstName: name, familyName: familyName, phoneNum: num)
            self.arrContact.append(contactToAppend)
            self.dataArrayContact.removeAll()
            let dh = DatabaseHandler()
            dh.saveData(firstName: name, lastName: familyName, phoneNum: num!)
            self.dataArrayContact = dh.fetchData()
            print(self.dataArrayContact)
                        
            self.tableView.reloadData()
        }
    }
}

extension ViewController {
    
    func setUI(){
        
        let authorise = CNContactStore.authorizationStatus(for: .contacts)
        if authorise == .notDetermined {
            
            store.requestAccess(for: .contacts) { (chk, error) in
                if error == nil {
                    
                    self.fetchContacts()
                }
            }
        } else if authorise == .authorized {
                
            self.fetchContacts()
            }
        
        let nib = UINib(nibName: "ContactCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ContactCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !arrContact.isEmpty {
            
            print(arrContact.count)
            return arrContact.count
        } else {
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        
        let contactData = arrContact[indexPath.row]
        
        cell.lblName.text = "\(contactData.firstName!)" + " " + "\(contactData.familyName!)"
        cell.lblNum.text = contactData.phoneNum
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contactSel = arrContact[indexPath.row]
        
        let alert = UIAlertController(title: "Innvonix Text", message: "Enter Name", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Enter FirstName"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Family Name"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Phone num"
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            
            let name = alert?.textFields![0].text
            let familyName = alert?.textFields![1].text
            let phone = alert?.textFields![2].text
            
            let dh = DatabaseHandler()
            dh.saveData(firstName: name!, lastName: familyName!, phoneNum: phone!)
            
            self.dataArrayContact[indexPath.row].firstName = name
            self.dataArrayContact[indexPath.row].familyName = familyName
            self.dataArrayContact[indexPath.row].phoneNumber = phone
            
            self.arrContact[indexPath.row].firstName = name
            self.arrContact[indexPath.row].familyName = familyName
            self.arrContact[indexPath.row].phoneNum = phone
            
            self.dataArrayContact = dh.fetchData()
            self.tableView.reloadData()
        }))
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
