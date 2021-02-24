//
//  ViewController.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 28.01.2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    var timer: Timer?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Button customizations
        registerButton.layer.borderWidth = 2
        registerButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.white.cgColor
        let status = Reach().connectionStatus()
        switch status
        {
            case .unknown, .offline:
                print("Not connected")
                makeAlert(titleInput: "Aoo!", messageInput: "There is no internet connection for login please activate your internet connection.")
                timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
                    let status = Reach().connectionStatus()
                    switch status {
                    case .unknown, .offline:
                        print("Not connected")
                    case .online(.wwan), .online(.wiFi):
                        print("Connected")
                        let currentUser = Auth.auth().currentUser
                        print("Core Data User Sayısı")
                        print(CoreDataUtil.numberOfCoreUser())
                        if currentUser != nil
                        {
                            if CoreDataUtil.getCurrentUser().getIsActive() //if it has been logined
                            {
                                self.performSegue(withIdentifier: "toZero", sender: self)
                            }
                            else//logout yap
                            {
                                do
                                {
                                    try Auth.auth().signOut()
                                    CoreDataUtil.removeUserFromCoreData()
                                    print("There is auth but stay active is closed.")
                                }
                                catch{print("error")}
                            }
                        }
                        else
                        {
                            print("There is no auth.")
                            self.loginButton.isEnabled = true
                            self.registerButton.isEnabled = true
                            
                        }
                    }
                }
            case .online(.wwan):
                print("Connected via WWAN")
            case .online(.wiFi):
                print("Connected via WiFi")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        if timer != nil
        {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func makeAlert(titleInput:String, messageInput:String)//Error method with parameters
    {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated:true, completion: nil)
    }
    
    @IBAction func loginButtonClicked(_ sender: Any)
    {
        let status = Reach().connectionStatus()
        switch status
        {
        case .unknown, .offline:
            makeAlert(titleInput: "Aooo!", messageInput: "There is no internet connection for login please activate your internet connection.")
        case .online(.wwan), .online(.wiFi):
            self.performSegue(withIdentifier: "toLogin", sender: self)
        }
    }
    
    

    @IBAction func registerButtonClicked(_ sender: Any)
    {
        let status = Reach().connectionStatus()
        switch status
        {
        case .unknown, .offline:
            print("Not connected")
            makeAlert(titleInput: "Aooo!", messageInput: "There is no internet connection for register please activate your internet connection.")
        case .online(.wwan), .online(.wiFi):
            self.performSegue(withIdentifier: "toRegister", sender: self)
        }
    }
    
}

