//
//  CalculatorViewController.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/04/30.
//

import UIKit
import SnapKit

class CalculatorViewController: UIViewController {

    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillInputView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()

    private lazy var vStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 16
        sv.addArrangedSubview(logoView)
        let views = [logoView, resultView, billInputView, tipInputView, splitInputView]
        views.forEach { sv.addArrangedSubview($0) }
        sv.addArrangedSubview(UIView())

        return sv
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        self.view.addSubview(vStackView)
        layout()
    }

    private func layout() {
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }


}
