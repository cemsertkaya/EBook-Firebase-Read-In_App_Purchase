//
//  FirstController.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 29.01.2021.
//

import UIKit
import Firebase

class FirstController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var libraryButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    let user =  Auth.auth().currentUser
    var isActive = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeWhiteBorder(button: homeButton)
        makeWhiteBorder(button: readButton)
        makeWhiteBorder(button: accountButton)
        makeWhiteBorder(button: libraryButton)
        makeWhiteBorder(button: buyButton)
        makeWhiteBorder(button: logOutButton)
        if isActive != nil && CoreDataUtil.numberOfCoreUser() == 0
        {
            FirebaseUtil.getUserDataAndCreateCore(userId: user!.uid, isActive: isActive)
            
        }
        else
        {
            print("error")
        }
        print(CoreDataUtil.getCurrentUser().toString())
        
    }
    
    @IBAction func buyButtonAction(_ sender: Any){self.performSegue(withIdentifier: "toLibrary2", sender: self)}
    
    @IBAction func libraryButtonAction(_ sender: Any){self.performSegue(withIdentifier: "toLibrary", sender: self)}
    
    @IBAction func homeButtonAction(_ sender: Any){}
    
    @IBAction func readButtonAction(_ sender: Any){self.performSegue(withIdentifier: "toRead", sender: self)}
    
    @IBAction func accountButtonAction(_ sender: Any){self.performSegue(withIdentifier: "toAccount", sender: self)}
    
   /// It selects the cell button type
   override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
           if segue.identifier == "toLibrary"
           {
               let destinationVC = segue.destination as! LibraryController
               destinationVC.controllerType = false
           }
           else if segue.identifier == "toLibrary2"
           {
              let destinationVC = segue.destination as! LibraryController
              destinationVC.controllerType = true
           }
    }
    
    
    func makeWhiteBorder(button: UIButton)
    {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func logOutButtonClicked(_ sender: Any)
    {
        do
        {
           try Auth.auth().signOut()
           CoreDataUtil.removeUserFromCoreData()
           self.performSegue(withIdentifier: "toZero", sender: nil)
        }
        catch
        {
            print("error")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
