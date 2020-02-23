//
//  BuilderAssembler.swift
//  News
//
//  Created by Trung Vu on 2/4/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import Swinject
class BuilderAssembler {
    
    static var allAssemblies : [Assembly] {
        
        let assemblies: [Assembly] = [
            ViewAssembler(),
            CoreAssembler()
        ]
        return assemblies
    }
}
