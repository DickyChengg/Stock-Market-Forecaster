//
//  String.swift
//  StockMarketForecaster
//
//  Created by Dicky on 02/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import Foundation

extension Double {
    func decimal(_ total: Int) -> String {
        String(format: "%\(total)g", self)
    }
    
    func decimalLessThanOne(_ total: Int) -> String {
        String(format: "%.\(total)g", self)
    }
}

