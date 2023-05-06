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
        input.billPublisher.sink { value in
            print("VM: \(value)")
        }.store(in: &cancellables)

        let result = ResultTip(totalTipPerPerson: 3000, totalBill: 9000, totalTip: 3)

        return Output(updateViewController: Just(result).eraseToAnyPublisher())
    }

}
