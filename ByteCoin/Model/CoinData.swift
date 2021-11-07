//
//  CoinData.swift
//  ByteCoin
//
//  Created by Cam Riemensnider on 11/7/21.
//  Copyright © 2021 Cam Dresie. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    
    let asset_id_quote: String
    let asset_id_base: String
    let rate: Double
}
    

