//
//  Optional.swift
//  StockMarketForecaster
//
//  Created by Dicky on 01/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import Foundation

extension Optional {
    func ifNil(_ value: Wrapped) -> Wrapped {
        if let currentValue = self {
            return currentValue
        }
        return value
    }
}
