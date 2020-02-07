//
//  SaveCell.swift
//  AMP
//
//  Created by Trung Vu on 5/26/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import UIKit

class SaveCell: UITableViewCell {
    
    @IBOutlet weak var saveButton: UIButton!
    
    var callBackLogout: (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        saveButton.setCornerRadius(radius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func saveAction(_ sender: Any) {
        callBackLogout?()
    }
}
