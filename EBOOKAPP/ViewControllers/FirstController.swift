//
//  FirstController.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 29.01.2021.
//

import UIKit

class FirstController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeWhiteBorder(button: homeButton)
        makeWhiteBorder(button: readButton)
        makeWhiteBorder(button: accountButton)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func homeButtonAction(_ sender: Any)
    {
    }
    
    @IBAction func readButtonAction(_ sender: Any)
    {
        self.performSegue(withIdentifier: "toRead", sender: self)
    }
    
    @IBAction func accountButtonAction(_ sender: Any)
    {
        self.performSegue(withIdentifier: "toAccount", sender: self)
    }
    
    func makeWhiteBorder(button: UIButton)
    {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
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
