//
//  DynamicMLModelError.swift
//  StockMarketForecaster
//
//  Created by Dicky on 01/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import Foundation

enum DynamicMLModelError: Error {
    case errorMessages([String])
    
    var localizedDescription: String {
        switch self {
        case .errorMessages(let errors):
            return errors.joined(separator: "\n")
        }
    }
}
