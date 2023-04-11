//
//  ViewController.swift
//  Core Data
//
//  Created by Sneh kalariya on 07/04/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func saveDataAction(_ sender: UIButton) {
        if let x = idTextField.text,let y = Int(x) {
            addData(id: y, name: nameTextField.text!)
        }
    }
    @IBAction func showDataAction(_ sender: UIButton) {
        getData()
    }
    @IBAction func deleteDataAction(_ sender: UIButton) {
        if let x = idTextField.text,let y = Int(x) {
            deleteData(id: y)
        }
    }
    func addData(id: Int,name: String){
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manegeContex = appDeleget.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "Student", in: manegeContex)!
        
        let user = NSManagedObject (entity: userEntity, insertInto: manegeContex)
        user.setValue(name, forKey: "name")
        user.setValue(id, forKey: "id")
        print (user)
    }
    func getData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContex = appDelegate.persistentContainer.viewContext
        let fetchRequest = Student.fetchRequest()
        do{
            let result = try managedContex.fetch(fetchRequest)
            for data in result {
                print(data.name as! String,data.id)
            }
            print("Data Get\n")
        }
        catch {
            print("Could not Save")
        }
        navigate()
    }
    func upDate(){
        
    }
    func deleteData(id: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContex = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        do{
            let test = try managedContex.fetch(fetchRequest)
            let objToDelete = test[0] as!NSManagedObject
            managedContex.delete(objToDelete)
            appDelegate.saveContext()
            print("Data Delete")
        }
        catch{
            print(error)
        }
    }
    func navigate() {
       
        let navigation = storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        navigationController?.pushViewController(navigation, animated: true)
    }
}

