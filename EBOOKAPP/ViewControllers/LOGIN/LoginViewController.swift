//
//  LoginViewController.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 29.01.2021.
//

import UIKit

class LoginViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self; tableView.dataSource = self
        makeWhiteBorder(button: loginButton)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func stayActiveButtonAction(_ sender: Any)
    {
        
    }
    
    @IBAction func loginButtonAction(_ sender: Any)
    {
        self.performSegue(withIdentifier: "toFirstController1", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "loginCell", for: indexPath) as! LoginCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        switch indexPath.row
        {
            case 0:
                cell.label.text = "E-Mail;"
                cell.view = view
                
            case 1:
                cell.label.text = "Password;"
                cell.view = view
            default:
                cell.label.text = "NULL"
                cell.view = view
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {return 100}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return 2}
    
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
