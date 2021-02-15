//
//  LibraryCell.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 7.02.2021.
//

import UIKit

class LibraryCell: UITableViewCell {

    var bookId = ""
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var label: UILabel!
    weak var viewController : LibraryController?
    var buttonType = Bool() // if false, it is library page. if true, it is buying page
    var pageNumber = Int64()
    
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
        makeWhiteBorder(button: readButton)
        if buttonType != nil
        {
            if buttonType == false
            {
                readButton.setTitle("READ", for: UIControl.State.normal)
            }
            else
            {
                readButton.setTitle("BUY", for: UIControl.State.normal)
            }
        }
    }
    
  
    func makeWhiteBorder(button: UIButton)
    {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
    }
    
    
    
    
}
