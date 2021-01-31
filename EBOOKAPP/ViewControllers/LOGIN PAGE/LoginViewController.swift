//
//  LoginViewController.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 29.01.2021.
//

import UIKit
import Firebase
import CoreData

class LoginViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stayActiveMarkButton: UIButton!
    var isStayActive = false
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self; tableView.dataSource = self
        makeWhiteBorder(button: loginButton)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "loginCell", for: indexPath) as! LoginCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        switch indexPath.row
        {
            case 0:
                cell.label.text = "E-Mail;"
                cell.view = view
                
            case 1:
                cell.label.text = "Password;"
                cell.view = view
                cell.textField.isSecureTextEntry = true
            default:
                cell.label.text = "NULL"
                cell.view = view
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {return 100}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return 2}
    func makeWhiteBorder(button: UIButton){button.layer.borderWidth = 2;button.layer.borderColor = UIColor.white.cgColor}
    
    func isStayActiveControl()
    {
        if !isStayActive
        {
            stayActiveMarkButton.setBackgroundImage(UIImage(named: "checked"), for: .normal)
            isStayActive = true
        }
        else
        {
            stayActiveMarkButton.setBackgroundImage(UIImage(named: "unchecked"), for: .normal)
            isStayActive = false
        }
    }
    
    func makeAlert(titleInput:String, messageInput:String)//Error method with parameters
    {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated:true, completion: nil)
    }
    
    @IBAction func stayActiveButtonAction(_ sender: Any){isStayActiveControl()}
    @IBAction func stayActiveImageButtonAction(_ sender: Any){isStayActiveControl()}
    
    func getCell(index : Int) -> LoginCell
    {
        let indexPath = NSIndexPath(row: index, section: 0)
        let multilineCell = tableView.cellForRow(at: indexPath as IndexPath) as? LoginCell
        return multilineCell!
    }
    
    @IBAction func loginButtonAction(_ sender: Any)
    {
        loginButton.isEnabled = false
        let email = getCell(index: 0).textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = getCell(index: 1).textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if email != "" && password != "" //if email and password is not empty
        {
            Auth.auth().signIn(withEmail: email, password: password)//Firebase signIn methods
            { (authData, error) in
                if error != nil
                {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                    self.loginButton.isEnabled = true
                }
                else
                {
                    self.saveItem(isActive: self.isStayActive)
                    let user = Auth.auth().currentUser
                    self.performSegue(withIdentifier: "toFirstController1", sender: self)
                }
            }
        }
    }
    
    func saveItem(isActive: Bool)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context =  appDelegate.persistentContainer.viewContext
        let newEntity = NSEntityDescription.insertNewObject(forEntityName:"Entity", into: context)
        newEntity.setValue(isActive, forKey: "isActive")
    }
    
}
