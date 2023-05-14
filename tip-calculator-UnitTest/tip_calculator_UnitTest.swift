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
    var logoTapSubject: PassthroughSubject<Void, Never>!
    var audioPlayerService: MockAudioPlayerService!

    override func setUp() {
        audioPlayerService = .init()
        sut = .init(audioPlayer: audioPlayerService)
        cancellables = .init()
        logoTapSubject = .init()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
        logoTapSubject = nil
    }

    func testResultWithoutTipFor1Person() {
        // given
        let bill: Double = 100.0
        let tip: Tip = .none
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

    func testResultWithoutTipFor2Person() {
        // given
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 2

        let input = buildInput(bill: bill, tip: tip, split: split)
        // when
        let output = sut.transform(input: input)

        // then
        output.updateViewController.sink { result in
            XCTAssertEqual(result.totalBill, 100.0)
            XCTAssertEqual(result.totalBillPerPerson, 50.0)
            XCTAssertEqual(result.totalTip, 0.0)
        }.store(in: &cancellables)
    }

    func testResultWithTenPercentTipFor2Person() {
        // given
        let bill: Double = 100.0
        let tip: Tip = .tenPercent
        let split: Int = 2

        let input = buildInput(bill: bill, tip: tip, split: split)
        // when
        let output = sut.transform(input: input)

        // then
        output.updateViewController.sink { result in
            XCTAssertEqual(result.totalBill, 110.0)
            XCTAssertEqual(result.totalBillPerPerson, 55.0)
            XCTAssertEqual(result.totalTip, 10.0)
        }.store(in: &cancellables)
    }

    func testResultWithCustomTipFor4Person() {
        // given
        let bill: Double = 100.0
        let tip: Tip = .custom(value: 60)
        let split: Int = 4

        let input = buildInput(bill: bill, tip: tip, split: split)
        // when
        let output = sut.transform(input: input)

        // then
        output.updateViewController.sink { result in
            XCTAssertEqual(result.totalBill, 160.0)
            XCTAssertEqual(result.totalBillPerPerson, 40.0)
            XCTAssertEqual(result.totalTip, 60.0)
        }.store(in: &cancellables)
    }

    func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input {
        return CalculatorVM.Input.init(billPublisher: Just(bill).eraseToAnyPublisher(),
                                       tipPublisher: Just(tip).eraseToAnyPublisher(),
                                       splitPublisher: Just(split).eraseToAnyPublisher(),
                                       logoTapPublisher: logoTapSubject.eraseToAnyPublisher())
    }

    func testSoundAndResetValues() {
        // given
        let bill: Double = 0
        let tip: Tip = .none
        let split: Int = 1

        let input = buildInput(bill: bill, tip: tip, split: split)

        let expectation1 = XCTestExpectation(description: "input의 값이 초기화 되어야 합니다.")
        let expectation2 = audioPlayerService.expectation

        // when
        let output = sut.transform(input: input)
        output.updateLogoView.sink { _ in
            expectation1.fulfill()
        }.store(in: &cancellables)

        logoTapSubject.send()

        // then
        wait(for: [expectation1, expectation2], timeout: 1.0)
    }

}

class MockAudioPlayerService: AudioPlayerService {

    var expectation = XCTestExpectation(description: "Audio Player 재생이 되어야 합니다.")

    func playSound() {
        expectation.fulfill()
    }


}
