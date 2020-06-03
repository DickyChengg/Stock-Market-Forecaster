//
//  Array+NSCopying.swift
//  StockMarketForecaster
//
//  Created by Dicky on 02/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import Foundation

extension Array where Element: NSCopying {
    func copy(with zone: NSZone? = nil) -> [Element] {
        var result: [Element] = []
        for element in self {
            let copiedElement = element.copy(with: zone) as? Element
            if let data = copiedElement {
                result.append(data)
            }
        }
        
        return result
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0 && index < self.count else { return nil }
        return self[index]
    }
}
