//
//  MeViewController.swift
//  News
//
//  Created by Trung Vu on 2/4/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD
import RxDataSources
import MobileCoreServices
import AVFoundation

enum accountDataType: String {
    case avatar
    case name
    case mobilePhone
    case email
    case password
    case address
    case birthDay
    case gender
    case maritalStatus
    case profession
}

struct AccountData {
    var id: accountDataType?
    var propertyName: String?
    var propertyValue: String?
}

enum CellModel {
    case avatar( data: AccountData)
    case propertyField(data: AccountData)
    case phoneNumber(data: AccountData)
    case birthDay(data: AccountData)
    case gender(data: AccountData)
    case maritalStatus(data: AccountData)
    case profession(data: AccountData)
    case buttonSave
}

class MeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
        
    let dataSource = PublishSubject<[AccountData]>()
    
    var rxDataSource : RxTableViewSectionedReloadDataSource<SectionModel<String, CellModel>>!

    fileprivate lazy var didCallUpdateProfile : Bool = false
    
    var viewModel: AccountViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        rxDataSource = bindingDataSource()
        bindingData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupUI() {
        tableView.registerCellNib(AccountHeaderCell.self)
        tableView.registerCellNib(AccountDataCell.self)
        tableView.registerCellNib(PhoneNumberCell.self)
        tableView.registerCellNib(BirthDayCell.self)
        tableView.registerCellNib(AccountPickerViewCell.self)
        tableView.registerCellNib(SaveCell.self)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func bindingData() {
        self.viewModel.createDataSource()
                   .observeOn(MainScheduler.instance)
                   .bind(to: tableView.rx.items(dataSource: rxDataSource))
                   .disposed(by: rxDisposeBag)
    }
    
    private func bindingDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, CellModel>> {
        weak var weakSelf = self
        
        let rxDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, CellModel>>(configureCell: { dataSource, table, indexPath, item in
            guard let myself = weakSelf else { return  UITableViewCell() }
            // turn off the boolean flag for requesting update user's profile
            myself.didCallUpdateProfile = false
            switch item {
            case .avatar(let data):
                return myself.makeAccountHeaderCell(with: data, from: self.tableView, indexPath: indexPath) ?? UITableViewCell()
            case .propertyField(let data):
                return myself.makeAccountDataItemCell(with: data, from: self.tableView, indexPath: indexPath) ?? UITableViewCell()
            case .phoneNumber(let data):
                return myself.makePhoneNumberCell(with: data, from: self.tableView, indexPath: indexPath) ?? UITableViewCell()
            case .birthDay(let data):
                return myself.makeBirthDayCell(with: data, from: self.tableView, indexPath: indexPath) ?? UITableViewCell()
            case .gender(let data):
                return myself.makePickerCell(with: data, from: self.tableView, indexPath: indexPath) ?? UITableViewCell()
            case .maritalStatus(let data):
                return myself.makePickerCell(with: data, from: self.tableView, indexPath: indexPath) ?? UITableViewCell()
            case .profession(let data):
                return myself.makePickerCell(with: data, from: self.tableView, indexPath: indexPath) ?? UITableViewCell()
            case .buttonSave:
                return myself.makeSaveCell(from: self.tableView, indexPath: indexPath) ?? UITableViewCell()
            }
        })
        
        return rxDataSource
    }
   
    private func makeAccountHeaderCell(with element: AccountData, from table: UITableView, indexPath: IndexPath) -> AccountHeaderCell? {
        let cell : AccountHeaderCell = tableView.dequeueReusableCell(withClass: AccountHeaderCell.self,  for: indexPath)
        return cell
    }

    private func makeAccountDataItemCell(with element: AccountData, from table: UITableView, indexPath: IndexPath) -> AccountDataCell? {
        let cell: AccountDataCell = tableView.dequeueReusableCell(withClass: AccountDataCell.self, for: indexPath)
        cell.setData(element)
        return cell
    }
    
    private func makePhoneNumberCell(with element: AccountData, from table: UITableView, indexPath: IndexPath) -> PhoneNumberCell? {
        let cell: PhoneNumberCell = tableView.dequeueReusableCell(withClass: PhoneNumberCell.self, for: indexPath)
        cell.phoneNumberTextField.text = element.propertyValue
        return cell
    }
    
    private func makeBirthDayCell(with element: AccountData, from table: UITableView, indexPath: IndexPath) -> BirthDayCell? {
        let cell: BirthDayCell = tableView.dequeueReusableCell(withClass: BirthDayCell.self, for: indexPath)
        return cell
    }
    
    private func makePickerCell(with element: AccountData, from table: UITableView, indexPath: IndexPath) -> AccountPickerViewCell? {
        let cell: AccountPickerViewCell = tableView.dequeueReusableCell(withClass: AccountPickerViewCell.self, for: indexPath)
        return cell
    }
    
    private func makeSaveCell(from table: UITableView, indexPath: IndexPath) -> SaveCell? {
        let cell: SaveCell = tableView.dequeueReusableCell(withClass: SaveCell.self, for: indexPath)
        cell.callBackLogout = {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.showAlert(title: "Warming", message: "Are you want to logout?", cancelTitle: nil, okTitle: "OK", cancelCallback: nil, okCallBack: {
                LoginManager.showLoginFlow(keyWindow)
            })
        }
        return cell
    }
}


