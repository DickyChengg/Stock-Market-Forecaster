//
//  StockMarketModelInput.swift
//  StockMarketForecaster
//
//  Created by Dicky on 01/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import CoreML

internal final class StockMarketModelInput: DynamicMLModelInput {
    private(set) var data: [String: Any]
    var featureNames: Set<String> = ["Open", "High", "Low", "Volume", "Timestamp"]
    
    // MARK: - Initializations
    init() {
        data = [:]
    }
    
    init(data: [String : Any]) {
        self.data = data
    }
    
    // MARK: - Setter Methods
    func set(open: Double) {
        data["Open"] = open
    }
    
    func set(high: Double) {
        data["High"] = high
    }
    
    func set(low: Double) {
        data["Low"] = low
    }
    
    func set(volume: Double) {
        data["Volume"] = volume
    }
    
    func set(timestamp: Double) {
        data["Timestamp"] = timestamp
    }
    
    // MARK: - General Methods
    func validateInput() throws {
        var errorMessages: [String] = []
        let keys = data.keys
        
        for featureName in featureNames {
            if !keys.contains(featureName) {
                errorMessages.append("`\(featureName)` not found!")
            }
        }
        
        if !errorMessages.isEmpty {
            throw DynamicMLModelError.errorMessages(errorMessages)
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        guard let str = data[featureName] as? String, let doubleValue = Double(str) else { return nil }
        return MLFeatureValue(double: doubleValue)
    }
}
