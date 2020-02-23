//
//  AccountPickerViewCell.swift
//  AMP
//
//  Created by Trung Vu on 5/26/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AccountPickerViewCell: UITableViewCell {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleTextField: UILabel!
    
    var pickerView: UIPickerView?
    
    private let heightPickerView = CGFloat(200)
    
    var list : [String]?
    
    var textSelected: String?{
        didSet{
            textField.text = textSelected
        }
    }
    
    /// BehaviorRelay for user input
    let brUserInput : BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.width, height: heightPickerView))
        pickerView?.delegate = self
        pickerView?.dataSource = self
        textField.inputView = pickerView
        textField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ data: AccountData){
        guard let dataId = data.id else { return }
        
        titleTextField.text = data.propertyName?.uppercased()
        textField.text = data.propertyValue
        
        switch dataId {
        case .gender:
            textField.placeholder = "AccountInfo.GenderPlaceHolder".localized()
        case .maritalStatus:
            textField.placeholder = "AccountInfo.MaritalStatusPlaceHolder".localized()
        case .profession:
            textField.placeholder = "AccountInfo.ProfessionPlaceHolder".localized()
        default:
            break
        }
    }
    
    /// Auto select index after setup from user's data
    fileprivate func autoSelectIndexForPickerView() {
        /// do the validation
        /// check if list data is not empty and the text field was already populated by the user's data
        guard let listData = list, !listData.isEmpty, let value = textField.text, !value.isEmpty else { return }
        
        /// find the index of value in the listData
        guard let idx = listData.firstIndex(where: { $0 == value}) else { return }
        
        pickerView?.selectRow(idx, inComponent: 0, animated: false)
    }
    
    
}


// MARK: - UITextFieldDelegate
extension AccountPickerViewCell : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.inputView == pickerView {
            autoSelectIndexForPickerView()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.inputView == pickerView {
            guard let listData = list, !listData.isEmpty, let idx = pickerView?.selectedRow(inComponent: 0) else { return }
            
            self.textField.text = listData[idx]
            
            self.brUserInput.accept(listData[idx])
        }
    }
}

extension AccountPickerViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let items = list, items.count > 0 {
            return items[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let items = list, items.count > 0 {
            self.textField.text = items[row]
            self.brUserInput.accept(items[row])
        }
    }
}
