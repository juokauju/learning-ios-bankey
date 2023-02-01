//
//  CurrencyFormatterTests.swift
//  Udemy-BankeyUnitTests
//
//  Created by jimi bird on 2023-01-29.
//

import Foundation
import XCTest

@testable import Udemy_Bankey

class CurrencyFormatterTests: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testBreakDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(987807.78)
        XCTAssertEqual(result.0, "987,807")
        XCTAssertEqual(result.1, "78")
    }
    
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(123456.56)
        XCTAssertEqual(result, "$123,456.56")
    }
    
    func testZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0)
        XCTAssertEqual(result, "$0.00")

    }
}
