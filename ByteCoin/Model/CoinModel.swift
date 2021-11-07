//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Cam Riemensnider on 11/7/21.
//  Copyright © 2021 Cam Dresie. All rights reserved.
//

import Foundation

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

struct CoinModel {
    
    var rate: Double
    var currency: String
    var asset: String
    
    var rateString: String {
        return rate.withCommas()
    }
}
