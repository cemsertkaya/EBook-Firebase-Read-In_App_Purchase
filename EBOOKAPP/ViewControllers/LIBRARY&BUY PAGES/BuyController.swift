//
//  BuyController.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 25.02.2021.
//

import UIKit
import StoreKit
class BuyController: UIViewController, UITableViewDelegate,UITableViewDataSource, SKPaymentTransactionObserver, SKProductsRequestDelegate
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeButton: UIButton!
    var libraryMap = [String:Int64]()
    var productSelected = String()
    var products = [SKProduct]()
    var request: SKProductsRequest!
    var productIds = [String]()//fetch it from firestore
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self; tableView.dataSource = self
        SKPaymentQueue.default().add(self)
        getAvailableBooksForBuy()
        makeWhiteBorder(button: homeButton)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
            let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell", for: indexPath) as! LibraryCell
            cell.bookId = self.products[indexPath.row].productIdentifier
            cell.label.text = self.products[indexPath.row].localizedTitle.uppercased()
            cell.readButton.addTarget(self, action: #selector(buyAction(sender:)), for: .touchUpInside)
            cell.readButton.tag = indexPath.row
            return cell
    }
    
    func getAvailableBooksForBuy()
    {
        let docRef = singleton.instance().getBooksDatabase().getDocuments { [self] (querySnapshot, err) in
            if let err = err{print("Error getting documents: \(err)")}
            else
            {
                for document in querySnapshot!.documents
                {
                    if document.exists
                    {
                        if self.libraryMap[document.documentID] == nil
                        {
                            self.productIds.append(document.documentID)
                        }
                    }
                }
                if self.productIds.count == 0
                {
                    self.makeAlert(titleInput: "Aooo!", messageInput: "There is no ebook that you don't have.")
                }
                else
                {
                    self.validate(productIdentifiers: self.productIds)
                }
                
            }
        }
    }
    
    //Payment functions
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])
    {
        for transaction in transactions
        {
            if transaction.transactionState == .purchased
            {
                
                //print("The transaction is successful.")
                //makeAlert(titleInput: "Success", messageInput: "The transaction is successful. You can download and read this book from LIBRARY page.")
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                libraryMap[productSelected] = 0
                print("Product Selected: " + productSelected)
                if !libraryMap.isEmpty
                {
                    FirebaseUtil.updateEbooksDict(dict: libraryMap, userId: CoreDataUtil.getCurrentUser().getUserId())
                    self.performSegue(withIdentifier: "toLibraryFromBuy", sender: self)
                }
            }
            else if transaction.transactionState == .failed || transaction.transactionState == .deferred
            {
                print("The transaction has failed.")
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
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
            self.productSelected = transactionRequest.productIdentifier
            print(self.productSelected)
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
            DispatchQueue.main.async
            {
                self.tableView.reloadData()
            }
            
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
    
  
    // Swipe right
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer){if (sender.direction == .right){ self.performSegue(withIdentifier: "toFirstFromLibrary", sender: self)}}

    func makeWhiteBorder(button: UIButton)
    {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
    }
   
    @IBAction func homeButtonAction(_ sender: Any)
    {
        self.performSegue(withIdentifier: "toFirstFromBuy", sender: self)
    }
    
    /// It selects the cell button type
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
            if segue.identifier == "toLibraryFromBuy" //LIBRARY PAGE
            {
                
                let destinationVC = segue.destination as! LibraryController
                destinationVC.libraryMap = self.libraryMap
            }
    }
    
}
