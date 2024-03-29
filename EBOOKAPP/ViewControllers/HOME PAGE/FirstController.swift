//
//  FirstController.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 29.01.2021.
//

import UIKit
import Firebase

class FirstController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    let user =  Auth.auth().currentUser
    var isActive = Bool()
    var userEbooks = [String:Int64]()
    var activityView: UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        if isActive != nil && CoreDataUtil.numberOfCoreUser() == 0
        {
            FirebaseUtil.getUserDataAndCreateCore(userId: user!.uid, isActive: isActive)
            //self.userEbooks = FirebaseUtil.getEbooks(userId:user!.uid)
        }
        print("cem")
        getEbooks { (newMap, error) in
            if error == nil
            {
                print("success")
                self.removeSpinner()
            }
            else
            {
                print("error")
                self.removeSpinner()
            }
        }
        print(CoreDataUtil.getCurrentUser().toString())
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func getEbooks(completion: @escaping ([String:Int64]?, Error?) -> Void)
    {
        
        let docRef = singleton.instance().getUsersDatabase().document(user!.uid)
        
        docRef.getDocument
        {
           (document, error) in
           if let document = document, document.exists
           {
               let dataDescription = document.data()
               let newMap =  dataDescription?["ebooks"] as! [String:Int64]
               self.userEbooks = newMap
               completion(newMap,nil)
           }
           else if let error = error
           {
               completion(nil,error)
           }
           else
           {
              completion(nil,nil)
           }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return 4}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cellDefault = UITableViewCell()
        switch indexPath.row {
        case 0://HOME
            let cell0 =  tableView.dequeueReusableCell(withIdentifier: "singleCell", for: indexPath) as! SingleCell
            cell0.button.setTitle("HOME", for: UIControl.State.normal)
            cell0.buttonType = 0
            cell0.yourController = self
            cellDefault = cell0
        case 1://READ & ACCOUNT
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "doubleCell", for: indexPath) as! DoubleCell
            cell1.leftButton.setTitle("READ", for: UIControl.State.normal)
            cell1.rightButton.setTitle("ACCOUNT", for: UIControl.State.normal)
            cell1.leftButtonType = 0
            cell1.rightButtonType = 0
            cell1.yourController = self
            cellDefault = cell1
        case 2://BUY & LIBRARY
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "doubleCell", for: indexPath) as! DoubleCell
            cell2.leftButton.setTitle("BUY", for: UIControl.State.normal)
            cell2.rightButton.setTitle("LIBRARY", for: UIControl.State.normal)
            cell2.leftButtonType = 1
            cell2.rightButtonType = 1
            cell2.yourController = self
            cellDefault = cell2
        case 3: //LOGOUT
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "singleCell", for: indexPath) as! SingleCell
            cell3.button.setTitle("LOG OUT", for: UIControl.State.normal)
            cell3.buttonType = 1
            cell3.yourController = self
            cellDefault = cell3
        default:
            print("hata")

        }
        return cellDefault
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {return 80}
    
   /// It selects the cell button type
   override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
           if segue.identifier == "toLibrary"//LIBRARY PAGE
           {
               
               let destinationVC = segue.destination as! LibraryController
               destinationVC.libraryMap = userEbooks
           }
           else if segue.identifier == "toBuy" //BUY PAGE
           {
              let destinationVC = segue.destination as! BuyController
              destinationVC.libraryMap = userEbooks
           }
           else if segue.identifier == "toRead" //READ PAGE
           {
              let destinationVC = segue.destination as! PdfReaderController
              let id = CoreDataUtil.getCurrentUser().getCurrentBookId()
              destinationVC.currentFileUrl = id
              destinationVC.startingPageNumber = userEbooks[id]!
              destinationVC.libraryMapInPdf = userEbooks
           }
    }
    
    
    func showActivityIndicator()
    {
        activityView = UIActivityIndicatorView(style: .gray)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func hideActivityIndicator()
    {
        if (activityView != nil)
        {
            activityView?.stopAnimating()
        }
    }
    
}
