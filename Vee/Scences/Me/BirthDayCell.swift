//
//  BirthDayCell.swift
//  AMP
//
//  Created by Trung Vu on 5/26/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import UIKit

class BirthDayCell: UITableViewCell {

    var pickerDate: UIDatePicker?
    @IBOutlet weak var dateValueTextField: UITextField!
    @IBOutlet weak var titleTextField: UILabel!
    
    var valueDate: String? {
        didSet{
            dateValueTextField.text = valueDate
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pickerDate = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.width, height: 200))
        pickerDate?.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: .valueChanged)
        pickerDate?.datePickerMode = .date
        pickerDate?.maximumDate = Date()
        dateValueTextField.inputView = pickerDate
        dateValueTextField.placeholder = "AccountInfo.BirthdayPlaceHolder".localized()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        // Apply date format
   
        
    }
    
    func setData(_ data: AccountData){
        titleTextField.text = data.propertyName?.uppercased()
        dateValueTextField.text = data.propertyValue
    }
    
}


