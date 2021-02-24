//
//  LibraryController.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 7.02.2021.
//

import UIKit
import StoreKit

class LibraryController: UIViewController,UITableViewDelegate,UITableViewDataSource, SKPaymentTransactionObserver, SKProductsRequestDelegate
{
    @IBOutlet weak var homeButton: UIButton!
    var controllerType = Bool()
    @IBOutlet weak var tableView: UITableView!
    var products = [SKProduct]()
    var request: SKProductsRequest!
    var productIds = [String]()//fetch it from firestore
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
        if !controllerType//This is library view controller
        {
            libraryButton.setTitle("LIBRARY", for: UIControl.State.normal)
            
        }
        else//This is buy view controller
        {
            libraryButton.setTitle("BUY", for: UIControl.State.normal)
            print("ProductsIds:")
            print(productIds.count)
            SKPaymentQueue.default().add(self)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //This is library view controller
        if !controllerType{return booksForLibrary.count}
        //This is buy view controller
        else
        {
            return products.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell", for: indexPath) as! LibraryCell
        cell.buttonType = controllerType
        if !controllerType//This is library view controller
        {
            cell.bookId = self.booksForLibrary[indexPath.row].getId()
            cell.label.text = self.booksForLibrary[indexPath.row].getTitle().uppercased()
            libraryButton.setTitle("LIBRARY", for: UIControl.State.normal)
            cell.readButton.addTarget(self, action: #selector(libraryAction(sender:)), for: .touchUpInside)
            cell.readButton.tag = indexPath.row
            cell.viewController = self
        }
        else//This is buy view controller
        {
            cell.bookId = self.products[indexPath.row].productIdentifier
            cell.label.text = self.products[indexPath.row].productIdentifier.uppercased()
            cell.readButton.addTarget(self, action: #selector(buyAction(sender:)), for: .touchUpInside)
            cell.readButton.tag = indexPath.row
            libraryButton.setTitle("BUY", for: UIControl.State.normal)
        }
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
    
    func makeWhiteBorder(button: UIButton)
    {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
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
                        else// If user does not have this book
                        {
                            self.productIds.append(document.documentID)
                        }
                    }
                }
                print("Product IDs Count")
                print((String(self.productIds.count)))
                self.validate(productIdentifiers: self.productIds)
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
    
    @IBAction func homeButtonAction(_ sender: Any){self.performSegue(withIdentifier: "toFirstFromLibrary", sender: self)}
    
    // Swipe right
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer){if (sender.direction == .right){ self.performSegue(withIdentifier: "toFirstFromLibrary", sender: self)}}
    
    
    //Payment functions
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])
    {
        for transaction in transactions
        {
            if transaction.transactionState == .purchased
            {
                print("Transaction is successful.")
                makeAlert(titleInput: "Congrats", messageInput: transaction.transactionIdentifier!)
                
            }
            else if transaction.transactionState == .failed
            {
                print("The transaction has failed.")
            }
        }
    }
    
    @objc func buyAction(sender: UIButton)
    {
        if SKPaymentQueue.canMakePayments()
        {
            let transactionRequest = SKMutablePayment()
            transactionRequest.productIdentifier = products[sender.tag].productIdentifier
            SKPaymentQueue.default().add(transactionRequest)
        }
        else
        {
            print("The user cannot make transaction.")
        }
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if !response.products.isEmpty
        {
            products = response.products
            self.tableView.reloadData()
        }
    }
    
    func validate(productIdentifiers: [String])
    {
         let productIdentifiers = Set(productIdentifiers)
         request = SKProductsRequest(productIdentifiers: productIdentifiers)
         request.delegate = self
         request.start()
    }
    
    func makeAlert(titleInput:String, messageInput:String)//Error method with parameters
    {
            let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated:true, completion: nil)
    }

    
}






