//
//  StockMarketLocal.swift
//  StockMarketForecaster
//
//  Created by Dicky on 01/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import SwiftCSV
import SwiftyJSON

internal final class StockMarketLocal {
    enum Error: Swift.Error {
        case failedToReadCsv
        
        var localizedDescription: String {
            "Failed to read CSV"
        }
    }
    
    func load(
        ticker: String,
        onComplete: @escaping ([StockMarketEntity], Swift.Error?) -> Void
    ) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let resource: CSV? = try CSV(
                    name: ticker,
                    extension: "csv",
                    bundle: .main,
                    encoding: .utf8
                )
                guard let csv = resource else {
                    return onComplete([], Error.failedToReadCsv)
                }
                
                let jsonArray = JSON(csv.namedRows).arrayValue.suffix(100)
                let result: [StockMarketEntity] = jsonArray.map(StockMarketEntity.init)
                
                DispatchQueue.main.async {
                    onComplete(result, nil)
                }
            } catch {
                onComplete([], error)
            }
        }
    }
}
