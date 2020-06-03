//
//  StockMarketModelOutput.swift
//  StockMarketForecaster
//
//  Created by Dicky on 01/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import CoreML

internal final class StockMarketModelOutput: DynamicMLModelOutput {
    typealias Output = Double
    
    // MARK: - Properties
    private let provider: MLFeatureProvider
    
    var featureNames: Set<String> {
        provider.featureNames
    }
    
    lazy var output: Double = { [unowned self] in
        return self.provider.featureValue(for: self.provider.featureNames.first!)!.doubleValue
    }()
    
    // MARK: - Initializations
    init(features: MLFeatureProvider) {
        provider = features
    }
    
    // MARK: - General Methods
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return provider.featureValue(for: featureName)
    }
}
