//
//  DatabaseHandler.swift
//  Innvonix Test
//
//  Created by Anant Bhatt on 03/02/23.
//

import Foundation
import CoreData
import UIKit

class DatabaseHandler {
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveData(firstName: String, lastName: String, phoneNum : String){
     
        let context = appdelegate.persistentContainer.viewContext
        let contactObject = NSEntityDescription.insertNewObject(forEntityName: "ContactData", into: context) as! ContactData
        contactObject.firstName = firstName
        contactObject.familyName = lastName
        contactObject.phoneNumber = phoneNum
        do {
            try context.save()
            print("Data has been saved")
        } catch {
            
            print("Error has been occured during save Data")
        }
    }
    
    func fetchData()-> [ContactData]{

        var conData = [ContactData]()
        let context = appdelegate.persistentContainer.viewContext
        
        do {
            
            conData = try context.fetch(ContactData.fetchRequest()) as! [ContactData]
        } catch {
            
            print("error occured during fetching data")
        }
        
        return conData
    }
}
