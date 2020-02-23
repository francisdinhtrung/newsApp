//
//  AppResponse.swift
//  News
//
//  Created by Trung Vu on 2/7/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit

// MARK: - AppResponse
struct AppPaging: Codable {
    let status: String?
    let totalResults: Int?
    var articles: [Article] = []
    let error: AppError?
}
