//
//  DynamicMLModelOutput.swift
//  StockMarketForecaster
//
//  Created by Dicky on 01/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import CoreML

internal protocol DynamicMLModelOutput: AnyObject, MLFeatureProvider {
    init(features: MLFeatureProvider)
}
