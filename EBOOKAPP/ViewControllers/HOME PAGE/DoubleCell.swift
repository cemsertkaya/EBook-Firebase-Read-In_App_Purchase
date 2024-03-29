//
//  DoubleCell.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 13.02.2021.
//

import UIKit

class DoubleCell: UITableViewCell {

   
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    var leftButtonType = Int()// 0 -->  READ  1--> BUY
    var rightButtonType = Int()// 0 --> ACCOUNT 1 --> LIBRARY
    weak var yourController : FirstController?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        makeWhiteBorder(button: leftButton)
        makeWhiteBorder(button: rightButton)
        // Configure the view for the selected state
    }
    @IBAction func leftButtonClicked(_ sender: Any)
    {
        let status = Reach().connectionStatus()
        switch status
        {
            case .unknown, .offline:
                makeAlert(titleInput: "Aooo!!", messageInput: "Please open your internet for using app.")
            case .online(.wwan), .online(.wiFi):
                if leftButtonType == 0//READ
                {
                    if CoreDataUtil.getCurrentUser().getCurrentBookId() == ""
                    {
                        yourController!.performSegue(withIdentifier: "toLibrary", sender: yourController!)
                    }
                    else
                    {
                        print(CoreDataUtil.getCurrentUser().toString())
                        if yourController?.userEbooks.count != 0
                        {
                            yourController!.performSegue(withIdentifier: "toRead", sender: yourController!)
                        }
                        
                    }
                    
                }
                else if leftButtonType == 1 //BUY
                {
                    yourController!.performSegue(withIdentifier: "toBuy", sender: yourController!)
                    
                }
                else
                {
                    print("Left Button Type Error")
                }
        }
    }
    
    @IBAction func rightButtonClicked(_ sender: Any)
    {
        let status = Reach().connectionStatus()
        switch status
        {
            case .unknown, .offline:
                makeAlert(titleInput: "Aooo!!", messageInput: "Please open your internet for using app.")
            case .online(.wwan), .online(.wiFi):
                if rightButtonType == 0 //ACCOUNT
                {
                    yourController!.performSegue(withIdentifier: "toAccount", sender: yourController!)
                }
                else if rightButtonType == 1 //LIBRARY
                {
                    yourController!.performSegue(withIdentifier: "toLibrary", sender: yourController!)
                }
                else
                {
                    print("Right Button Type Error")
                }
        }
        
    }
    
    func makeWhiteBorder(button: UIButton)
    {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
    }
    
    func makeAlert(titleInput:String, messageInput:String)//Error method with parameters
    {
            let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            yourController!.present(alert, animated:true, completion: nil)
    }
}
