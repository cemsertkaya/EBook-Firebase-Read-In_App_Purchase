//
//  RegisterViewController2.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 29.01.2021.
//

import UIKit

class RegisterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var acceptTermsImageButton: UIButton!
    var isTermsAccepted = false
    let eBookLanguages = ["Bengali","Hindi","Russian","Italian","Japanese","Chinese tangerine","Arab","Spanish","English","French","Portuguese","German","Turkish"]
    let genders = ["Female","Male","Others"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self; tableView.dataSource = self
        makeWhiteBorder(button: doneButton)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return 6}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "registerCell", for: indexPath) as! RegisterCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        switch indexPath.row {
        case 0:
            cell.label.text = "E-mail"
            cell.view = view
        case 1:
            cell.label.text = "Password"
            cell.view = view
            cell.textField.isSecureTextEntry = true
        case 2:
            cell.label.text = "Age"
            cell.view = view
            cell.textField.keyboardType = UIKeyboardType.numberPad
        case 3:
            cell.label.text = "Country"
            let placeholderColor = UIColor.black
            cell.textField.attributedPlaceholder = NSAttributedString(string: "Please select your country.", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
            cell.isTextFieldPicker = true
            cell.array = Countries.getCountries()
            cell.textField.inputView = cell.picker
            createToolbar(textField: cell.textField)
        case 4:
            cell.label.text = "eBook Language"
            let placeholderColor = UIColor.black
            cell.textField.attributedPlaceholder = NSAttributedString(string: "Please select your language.", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
            cell.isTextFieldPicker = true
            cell.array = eBookLanguages
            cell.textField.inputView = cell.picker
            createToolbar(textField: cell.textField)

        case 5:
            cell.label.text = "Gender"
            let placeholderColor = UIColor.black
            cell.textField.attributedPlaceholder = NSAttributedString(string: "Please select your gender.", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
            cell.isTextFieldPicker = true
            cell.array = genders
            cell.textField.inputView = cell.picker
            createToolbar(textField: cell.textField)
        default:
            cell.label.text = "NUll"
        }
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {return 1}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {return 79}
    
    func createToolbar(textField : UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegisterViewController.dismissPicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    @objc func dismissPicker() {view.endEditing(true)}
    func makeWhiteBorder(button: UIButton)
    {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
    }
    func isTermsAcceptedControl()
    {
        if !isTermsAccepted
        {
            acceptTermsImageButton.setBackgroundImage(UIImage(named: "checked"), for: .normal)
            isTermsAccepted = true
        }
        else
        {
            acceptTermsImageButton.setBackgroundImage(UIImage(named: "unchecked"), for: .normal)
            isTermsAccepted = false
        }
    }
    
    @IBAction func acceptTermsImageButtonAction(_ sender: Any){isTermsAcceptedControl()}
    @IBAction func acceptTermsButtonAction(_ sender: Any){isTermsAcceptedControl()}
    @IBAction func doneButtonAction(_ sender: Any)
    {
        let indexPath = NSIndexPath(row: 0, section: 0)
        let multilineCell = tableView.cellForRow(at: indexPath as IndexPath) as? RegisterCell
        print(multilineCell!.textField.text)
        self.performSegue(withIdentifier: "toFirstController2", sender: self)
    }
    
    
    
    

}
