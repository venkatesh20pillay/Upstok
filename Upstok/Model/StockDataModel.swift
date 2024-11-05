//
//  StockDataModel.swift
//  Upstok
//
//  Created by Venkatesh Pillay on 03/11/24.
//

import Foundation

struct StockDataModel: Decodable {
    let data: UserHoldingDataModel
}

struct UserHoldingDataModel: Decodable {
    let userHolding: [UserHoldingData]
}

struct UserHoldingData: Decodable {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double
}
