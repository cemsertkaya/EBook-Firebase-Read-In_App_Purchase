//
//  LibraryController.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 7.02.2021.
//

import UIKit

class LibraryController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var homeButton: UIButton!
    var controllerType = Bool()
    @IBOutlet weak var tableView: UITableView!
    var booksForBuy = [Book]()
    var booksForLibrary = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self; tableView.dataSource = self;
        makeWhiteBorder(button: homeButton)
        if !controllerType//This is library view controller
        {
            
        }
        else//This is buy view controller
        {
            var currentUserLanguage = CoreDataUtil.getCurrentUser().getLanguage()
            if currentUserLanguage != nil
            {
                self.getAvailableBooksForBuy(ebookLanguage: CoreDataUtil.getCurrentUser().getLanguage())
            }
            else
            {
                print("Language is nil")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if !controllerType//This is library view controller
        {
            return booksForLibrary.count
        }
        else//This is buy view controller
        {
            return booksForBuy.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell", for: indexPath) as! LibraryCell
        cell.buttonType = controllerType
        cell.label.text = self.booksForBuy[indexPath.row].getLanguageTitle()
        return cell
    }
    
    func makeWhiteBorder(button: UIButton)
    {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
    }
    
    func getAvailableBooksForBuy(ebookLanguage : String)
    {
        let docRef = singleton.instance().getBooksDatabase().getDocuments { (querySnapshot, err) in
            if let err = err{print("Error getting documents: \(err)")}
            else
            {
                for document in querySnapshot!.documents
                {
                    let id = document.documentID
                    if  document.exists
                    {
                        let dataDescription = document.data()
                        let languageId = dataDescription[ebookLanguage]
                        let docRef2 = singleton.instance().getBookNamesDatabase().getDocuments { (querySnapshot, err) in
                            if let err = err{print("Error getting documents: \(err)")}
                            else
                            {
                                for document in querySnapshot!.documents
                                {
                                    if document.exists
                                    {
                                        let dataDescription2 = document.data()
                                        let name = dataDescription2["name"] as! String
                                        if languageId != nil
                                        {
                                            let newBook = Book(mainId: id, languageId: languageId as! String, languageTitle:name)
                                            self.booksForBuy.append(newBook)
                                        }
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

}

    


