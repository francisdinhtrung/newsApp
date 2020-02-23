//
//  DiscoveryHeader.swift
//  News
//
//  Created by Trung Vu on 2/7/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import SwifterSwift
import PureLayout
class DiscoveryHeader: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var view : UIView!
    
    fileprivate let inset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    static let keywords = ["Bitcoin", "Apple", "Earthquake", "Animal"]
    
    var selectedIndex = 0 {
        didSet {
            
        }
    }
    
    var selectedHandler: ((_ keyword: Int) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        xibSetup()
        
    }
    
    /// init view from nib
    func xibSetup() {
        
        view = self.loadViewFromNib(name: String(describing: DiscoveryHeader.self))
        
        // use bounds not frame or it'll be offset
        view.layoutIfNeeded()
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below
        addSubview(view)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCellNib(TextViewCell.self)
        
        view.autoPinEdge(toSuperviewEdge: .left)
        view.autoPinEdge(toSuperviewEdge: .right)
        view.autoSetDimension(.height, toSize: 150)
        view.autoPinEdge(toSuperviewEdge: .top)
        view.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    
}

extension DiscoveryHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DiscoveryHeader.keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: TextViewCell.self, for: indexPath)
        cell.titleLabel.text = DiscoveryHeader.keywords[indexPath.row]
        if selectedIndex == indexPath.row {
            cell.backgroundColor = UIColor.red.withAlphaComponent(1)
        } else {
            cell.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath.row
        if let cb = self.selectedHandler {
            cb(selectedIndex)
            
        }
        self.collectionView.reloadData()
    }
    
}
