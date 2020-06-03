//
//  StockMarketEntity.swift
//  StockMarketForecaster
//
//  Created by Dicky on 01/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import SwiftDate
import SwiftyJSON

final class StockMarketEntity: NSCopying {
    var open: Double = 0.0
    var high: Double = 0.0
    var low: Double = 0.0
    var volume: Double = 0.0
    var close: Double = 0.0
    var timestamp: Double = 0.0
    private(set) var json: [String: Any] = [:]
    
    var dateString: String {
        Date(timeIntervalSince1970: timestamp).toFormat("d MMMM yyyy")
    }
    
    init(json: JSON) {
        self.json = json.dictionaryObject.ifNil([:])
        
        open = json["Open"].doubleValue
        high = json["High"].doubleValue
        low = json["Low"].doubleValue
        close = json["Close"].doubleValue
        volume = json["Volume"].doubleValue
        timestamp = json["Timestamp"].doubleValue
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let data = StockMarketEntity(json: [:])
        data.open = open
        data.high = high
        data.low = low
        data.volume = volume
        data.close = close
        data.timestamp = timestamp
        return data
    }
}
