//
//  PhoneNumberCell.swift
//  AMP
//
//  Created by Trung Vu on 5/26/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import UIKit

class PhoneNumberCell: UITableViewCell {

    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var textContentType : UITextContentType?
        
        phoneNumberTextField.keyboardType = .numberPad
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
