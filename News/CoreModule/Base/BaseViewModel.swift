//
//  BaseModel.swift
//  CoreModule
//
//  Created by Trung Vu on 2/4/20.
//  Copyright © 2019 Trung Vu. All rights reserved.
//

import RxSwift
import RxCocoa

class BaseViewModel: NSObject {
    
    var rxDisposeBag : DisposeBag {
        return DisposeBag()
    }
}
