//
//  StockMarketInteractor.swift
//  StockMarketForecaster
//
//  Created by Dicky on 01/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class StockMarketInteractor {
    private lazy var dataLoader = StockMarketLocal()
    
    func load(
        ticker: String,
        onComplete: @escaping ([StockMarketEntity], Error?) -> Void
    ) {
        dataLoader.load(ticker: ticker, onComplete: onComplete)
    }
    
    func predictions(data inputs: [BBCAInput]) throws -> [StockMarketEntity] {
        let result: [StockMarketEntity] = inputs.map { item in
            let data = StockMarketEntity(json: [:])
            data.open = item.Open
            data.high = item.High
            data.low = item.Low
            data.volume = item.Volume
            data.timestamp = item.Timestamp
            return data
        }
        
        let model = BBCA()
        let outputs: [BBCAOutput] = try model.predictions(inputs: inputs)
        
        for (index, output) in outputs.enumerated() {
            result[index].close = output.Close
        }
        return result
    }
    
    func predictions(ticker: String, data inputs: [StockMarketModelInput]) throws -> [StockMarketEntity] {
        let result: [StockMarketEntity] = inputs.map { item in
            let json = JSON(item.data)
            return StockMarketEntity(json: json)
        }
        
        let model = try DynamicMLModel<StockMarketModelInput, StockMarketModelOutput>(model: ticker)
        let outputs: [StockMarketModelOutput] = try model.predictions(inputs: inputs)
        
        for (index, output) in outputs.enumerated() {
            result[index].close = output.output
        }
        return result
    }
}
