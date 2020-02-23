//
//  TimelineDataModel.swift
//  Vee
//
//  Created by Trung Vu on 2/22/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import TimelineTableViewCell

struct TimelineDataModel {
    let timelinePoint: TimelinePoint
    let mainColor: UIColor
    let milestone: String
    let description: String
    let lineInfo: String
    let thumbnails: [String]
    let illustration: String
    
    init(with data: (TimelinePoint, UIColor, String, String, String?, [String]?, String?)) {
        var (timelinePoint, timelineBackColor, title, description, lineinfo, thumbnails, illustration) = data
        self.timelinePoint = timelinePoint
        mainColor = timelineBackColor
        milestone = title
        self.description = description
        self.thumbnails = thumbnails ?? []
        self.illustration = illustration ?? ""
        self.lineInfo = lineinfo ?? ""
    }
}
