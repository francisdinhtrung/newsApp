//
//  AccountDataCell.swift
//  AMP
//
//  Created by Trung Vu on 5/21/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import UIKit

class AccountDataCell: UITableViewCell {

    @IBOutlet weak var textFieldDataLabel: UILabel!
    @IBOutlet weak var valueDataLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(_ data: AccountData){
        textFieldDataLabel.text = data.propertyName?.uppercased()
        valueDataLabel.text = data.propertyValue
    }
}
