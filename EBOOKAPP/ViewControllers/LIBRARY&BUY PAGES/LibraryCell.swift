//
//  LibraryCell.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 7.02.2021.
//

import UIKit

class LibraryCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var label: UILabel!
    var buttonType = Bool() // if false, it is library page if true, it is buying page
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        // Configure the view for the selected state
    }
    
    @IBAction func readButtonAction(_ sender: Any)//it can be read or buy
    {
        if buttonType != nil
        {
            if buttonType == false
            {
                
            }
            else
            {
                
            }
        }
    }
    
}
