//
//  AccountHeaderCell.swift
//  AMP
//
//  Created by Trung Vu on 5/21/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import UIKit

class AccountHeaderCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var myAccountTitleLabel: UILabel!
    @IBOutlet weak var widthAvatar: NSLayoutConstraint!
    @IBOutlet weak var heightAvatar: NSLayoutConstraint!
    
    var dismissHandler: (()->())?
    
    var showPhotoPageHandler: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showPhotoPage(_ sender: Any) {
        if let cb = self.showPhotoPageHandler {
            cb()
        }
    }
    
    func setupUI() {
        avatarImageView.roundView()
    }
    
    @IBAction func uploadAction(_ sender: Any) {
        if let cb = self.showPhotoPageHandler {
            cb()
        }
    }
    

    
    @IBAction func dismissView(_ sender: Any) {
        if let cb = self.dismissHandler {
            cb()
        }
    }
}
