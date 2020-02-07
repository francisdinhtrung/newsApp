//
//  ViewModeltype.swift
//  News
//
//  Created by Trung Vu on 2/5/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
