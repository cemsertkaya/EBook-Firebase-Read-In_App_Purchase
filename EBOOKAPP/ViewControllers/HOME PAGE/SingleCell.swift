//
//  SingleCell.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 13.02.2021.
//

import UIKit
import Firebase

class SingleCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    var buttonType = Int() // 0 --> HOME 1 -- LOG OUT
    weak var yourController : FirstController?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        makeWhiteBorder(button: button)
        // Configure the view for the selected state
    }
    @IBAction func buttonClicked(_ sender: Any)
    {
        if buttonType == 0
        {
            
        }
        else if buttonType == 1
        {
            let status = Reach().connectionStatus()
            switch status
            {
                case .unknown, .offline:
                    makeAlert(titleInput: "Aooo!!", messageInput: "Please open your internet for using app.")
                case .online(.wwan), .online(.wiFi):
                    do
                    {
                       try Auth.auth().signOut()
                       CoreDataUtil.removeUserFromCoreData()
                       yourController!.performSegue(withIdentifier: "toZero", sender: yourController!)
                    }
                    catch
                    {
                        print("error")
                    }
            }
            
        }
        else
        {
            print("Button Type Error")
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
