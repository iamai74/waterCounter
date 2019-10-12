//
//  WaterData.swift
//  WaterCounter
//
//  Created by AI on 09.10.2019.
//  Copyright © 2019 iamai. All rights reserved.
//

import Foundation

struct WaterData: Codable {
    var dateTime: Date = Date()
    let value: Float
}
