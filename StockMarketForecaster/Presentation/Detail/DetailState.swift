//
//  DetailState.swift
//  StockMarketForecaster
//
//  Created by Dicky on 01/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import Foundation

internal final class DetailState {
    var ticker: String = ""
    
    var actualData: [StockMarketEntity] = []
    var predictedData: [StockMarketEntity] = []
    
    var selectedDate: String = "-"
    var actualClose: Double = 0
    var predictedClose: Double = 0
}
