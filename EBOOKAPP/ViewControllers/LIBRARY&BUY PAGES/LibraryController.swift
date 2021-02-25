//
//  LibraryController.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 7.02.2021.
//

import UIKit
import StoreKit

class LibraryController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var booksForLibrary = [Book]()
    @IBOutlet weak var libraryButton: UIButton!
    var libraryMap = [String:Int64]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        tableView.delegate = self; tableView.dataSource = self;
        makeWhiteBorder(button: homeButton)
        getAvailableBooksForLibrary()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return booksForLibrary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell", for: indexPath) as! LibraryCell
        cell.bookId = self.booksForLibrary[indexPath.row].getId()
        cell.label.text = self.booksForLibrary[indexPath.row].getTitle().uppercased()
        cell.readButton.addTarget(self, action: #selector(libraryAction(sender:)), for: .touchUpInside)
        cell.readButton.tag = indexPath.row
        cell.viewController = self
        return cell
    }
    
    @objc func libraryAction(sender: UIButton)
    {
        let id = self.booksForLibrary[sender.tag].getId()
        if FirebaseUtil.getPdfFromLibrary(id: id) != "" //it checks the book is downloaded to the library of phone
        {
            CoreDataUtil.updateCurrentUserBookId(currentBookId: id)
            print(CoreDataUtil.getCurrentUser().toString())
            self.performSegue(withIdentifier: "libraryToPdf", sender: self)
        }
        else// if the pdf is not downloaded before download it
        {
            print("böyle bir pdf yok indirilme işlemi yapılacak.....")
            CoreDataUtil.updateCurrentUserBookId(currentBookId: id)
            FirebaseUtil.getPdfFromStorageAndSave(id: id, controller: self)//download this pdf from firebase
            print(CoreDataUtil.getCurrentUser().toString())
        }
        
    }
    
    
    
    func presentActivityViewController(withUrl url: URL) {
        DispatchQueue.main.async
        {
          let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
          activityViewController.popoverPresentationController?.sourceView = self.view
          self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func getAvailableBooksForLibrary()
    {
        let docRef = singleton.instance().getBooksDatabase().getDocuments { (querySnapshot, err) in
            if let err = err{print("Error getting documents: \(err)")}
            else
            {
                for document in querySnapshot!.documents
                {
                    if document.exists
                    {
                        if let val = self.libraryMap[document.documentID]
                        {
                            let dataDescription = document.data()
                            let language = dataDescription["language"] as! String
                            let title = dataDescription["title"] as! String
                            let id = dataDescription["id"] as! String
                            let book = Book(id: id, language: language, title: title)
                            self.booksForLibrary.append(book)
                            print("Count:" + String(self.booksForLibrary.count))
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    /// It selects the cell button type
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
     {
        if segue.identifier == "libraryToPdf"
        {
            let vc = segue.destination as! PdfReaderController
            let id = CoreDataUtil.getCurrentUser().getCurrentBookId()
            vc.currentFileUrl = id
            let pageNumber = self.libraryMap[id]!
            vc.startingPageNumber = pageNumber
            vc.libraryMapInPdf = libraryMap
        }
     }
    
    
    func makeAlert(titleInput:String, messageInput:String)//Error method with parameters
    {
            let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated:true, completion: nil)
    }
    
    @IBAction func homeButtonAction(_ sender: Any){self.performSegue(withIdentifier: "toFirstFromLibrary", sender: self)}
    
    // Swipe right
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer){if (sender.direction == .right){ self.performSegue(withIdentifier: "toFirstFromLibrary", sender: self)}}

    func makeWhiteBorder(button: UIButton)
    {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
    }
    
}






