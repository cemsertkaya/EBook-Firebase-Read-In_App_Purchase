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
    let countries = ["Afghanistan","Albania","Algeria","American Samoa","Andorra","Angola","Anguilla", "Antigua & Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas",
                     "Bahrain", "Bangladesh", "Barbados", "Belarus",  "Belgium",  "Belize",  "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia & Herzegovina", "Botswana", "Brazil",  "British Indian Ocean Territory", "British Virgin Islands", "Brunei", "Bulgaria",  "Burkina Faso", "Burundi", "Cambodia",  "Cameroon",  "Canada",  "Canary Islands",  "Cape Verde", "Caribbean Netherlands", "Cayman Islands",  "Central African Republic", "Ceuta & Melilla", "Chad", "Chile", "China",  "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros",  "Congo - Brazzaville",  "Congo - Kinshasa", "Cook Islands",  "Costa Rica", "Croatia",  "Cuba", "Curaçao", "Cyprus", "Czechia",  "Côte d’Ivoire", "Denmark",  "Diego Garcia", "Djibouti",  "Dominica", "Dominican Republic", "Ecuador",  "Egypt",  "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Europe", "Falkland Islands (Islas Malvinas)",  "Faroe Islands",  "Fiji", "Finland", "France",  "French Guiana",  "French Polynesia", "Gabon", "Gambia", "Georgia", "Germany",  "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guernsey", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia",  "Iran", "Iraq", "Ireland",  "Isle of Man", "Israel", "Italy", "Jamaica", "Japan", "Jersey", "Jordan",  "Kazakhstan", "Kenya", "Kiribati", "Kosovo", "Kuwait", "Kyrgyzstan", "Laos", "Latin America", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau",  "Macedonia (FYROM)", "Madagascar", "Malawi", "Malaysia", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania",  "Mauritius", "Mayotte", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique",  "Myanmar (Burma)", "Namibia",  "Nauru", "Nepal", "Netherlands", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "North Korea", "Northern Mariana Islands", "Norway",  "Oman", "Pakistan", "Palau", "Palestine", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines",  "Pitcairn Islands",  "Poland", "Portugal", "Puerto Rico", "Qatar", "Romania", "Russia", "Rwanda", "Réunion",  "Samoa", "San Marino", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Sint Maarten", "Slovakia", "Slovenia", "Solomon Islands",  "Somalia", "South Africa", "South Korea", "South Sudan", "Spain", "Sri Lanka", "St. Barthélemy", "St. Helena", "St. Kitts & Nevis", "St. Lucia", "St. Martin", "St. Pierre & Miquelon", "St. Vincent & Grenadines", "Sudan", "Suriname", "Svalbard & Jan Mayen", "Swaziland", "Sweden", "Switzerland","Syria", "São Tomé & Príncipe", "Taiwan", "Tajikistan", "Tanzania", "Thailand",  "Timor-Leste", "Togo", "Tokelau",  "Tonga", "Trinidad & Tobago", "Tunisia", "Turkey", "Turks & Caicos Islands", "Tuvalu", "U.S. Outlying Islands", "U.S. Virgin Islands", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City", "Venezuela", "Vietnam", "Wallis & Futuna", "Western Sahara",  "World", "XA", "XB", "Yemen",  "Zambia", "Zimbabwe", "Åland Islands"]
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
        case 2:
            cell.label.text = "Age"
            cell.view = view
        case 3:
            cell.label.text = "Country"
            let placeholderColor = UIColor.black
            cell.textField.attributedPlaceholder = NSAttributedString(string: "Please select your country.", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
            cell.isTexFieldPicker = true
            cell.array = countries
            cell.textField.inputView = cell.picker
            createToolbar(textField: cell.textField)
        case 4:
            cell.label.text = "eBook Language"
            let placeholderColor = UIColor.black
            cell.textField.attributedPlaceholder = NSAttributedString(string: "Please select your language.", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
            cell.isTexFieldPicker = true
            cell.array = eBookLanguages
            cell.textField.inputView = cell.picker
            createToolbar(textField: cell.textField)

        case 5:
            cell.label.text = "Gender"
            let placeholderColor = UIColor.black
            cell.textField.attributedPlaceholder = NSAttributedString(string: "Please select your gender.", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
            cell.isTexFieldPicker = true
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

    @IBAction func doneButtonAction(_ sender: Any)
    {
        let indexPath = NSIndexPath(row: 0, section: 0)
        let multilineCell = tableView.cellForRow(at: indexPath as IndexPath) as? RegisterCell
        print(multilineCell!.textField.text)
        self.performSegue(withIdentifier: "toFirstController2", sender: self)
    }
    
    

}
