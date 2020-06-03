//
//  DynamicMLModelInput.swift
//  StockMarketForecaster
//
//  Created by Dicky on 01/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import CoreML

internal protocol DynamicMLModelInput: AnyObject, MLFeatureProvider {
    init()
    init(data: [String: Any])
    
    func validateInput() throws
}
