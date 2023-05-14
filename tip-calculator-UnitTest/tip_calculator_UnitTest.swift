//
//  tip_calculator_UnitTest.swift
//  tip-calculator-UnitTest
//
//  Created by Heonjin Ha on 2023/05/14.
//

import XCTest
import Combine
import CombineCocoa
@testable import tip_calculator

final class tip_calculator_UnitTest: XCTestCase {

    var sut: CalculatorVM!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        sut = .init()
        cancellables = .init()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
    }

    func testResultWithoutTipFor1Person() {
        // given
        let bill: Double = 100.0
        let tip: Tip = .custom(value: 0)
        let split: Int = 1

        let input = buildInput(bill: bill, tip: tip, split: split)
        // when
        let output = sut.transform(input: input)

        // then
        output.updateViewController.sink { result in
            XCTAssertEqual(result.totalBill, 100.0)
            XCTAssertEqual(result.totalBillPerPerson, 100.0)
            XCTAssertEqual(result.totalTip, 0.0)
        }.store(in: &cancellables)
    }

    func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input {
        return CalculatorVM.Input.init(billPublisher: Just(bill).eraseToAnyPublisher(),
                                            tipPublisher: Just(tip).eraseToAnyPublisher(),
                                            splitPublisher: Just(split).eraseToAnyPublisher(),
                                            logoTapPublisher: Just(()).eraseToAnyPublisher())
    }

}

// bill/p = $100
// total bill $100
// total tip $0
// split person 1
