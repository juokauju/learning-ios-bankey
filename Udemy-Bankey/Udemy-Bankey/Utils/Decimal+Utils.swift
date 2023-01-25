//
//  Decimal+Utils.swift
//  Udemy-Bankey
//
//  Created by jimi bird on 2023-01-27.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
