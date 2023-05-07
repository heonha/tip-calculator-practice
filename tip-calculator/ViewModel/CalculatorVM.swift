//
//  CalculatorVM.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/06.
//

import Foundation
import Combine

class CalculatorVM {

    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }

    struct Output {
        let updateViewController: AnyPublisher<ResultTip, Never>
    }

    private var cancellables = Set<AnyCancellable>()

    func transform(input: Input) -> Output {

        let updatePublishers = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher)
            .flatMap { [unowned self] (bill, tip, split) in
                let totalTip = getTipAmount(bill: bill, tip: tip)
                let totalBill = bill + totalTip
                let personPerBill = totalBill / split.doubleValue
                let result = ResultTip(totalTipPerPerson: personPerBill, totalBill: totalBill, totalTip: totalTip)

                return Just(result)
            }.eraseToAnyPublisher()

        return Output(updateViewController: updatePublishers)
    }

    func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.10
        case .fiftenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.20
        case .custom(let value):
            return value.doubleValue

        }
    }

}
