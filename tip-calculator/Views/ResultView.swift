//
//  ResultView.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/02.
//

import UIKit
import SnapKit
import SwiftUI
import Combine

class ResultView: UIView {


    private let headerLabel: UILabel = {
        return LabelFactory.build(text: "Total p/person", alignment: .center, font: AppFont.demiBold(ofSize: 18))
    }()

    private let billLabel: UILabel = {
        let text = NSMutableAttributedString.init(string: "$0", attributes: [.font: AppFont.bold(ofSize: 48)])
        text.addAttributes([ .font : AppFont.bold(ofSize: 30) ], range: NSMakeRange(0, 1))
        return LabelFactory.build(attributedText: text, alignment: .center)
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.separator
        return view
    }()

    private let totalBillView = AmountView(title: "Total bill", textAlignment: .left)
    private let totalTipView = AmountView(title: "Total tip", textAlignment: .right)

    private lazy var hStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            totalBillView,
            UIView(),
            totalTipView
        ])
        sv.axis = .horizontal
        sv.distribution = .fillEqually

        return sv
    }()

    private lazy var vStackView: UIView = {

        let sv = UIStackView(arrangedSubviews: [
            headerLabel,
            billLabel,
            separator,
            buildSpacerView(height: 0),
            hStackView
        ])
        sv.axis = .vertical
        sv.spacing = 8

        return sv
    }()

    private var resultSubject: PassthroughSubject<ResultTip, Never> = .init()
    var resultPublisher: AnyPublisher<ResultTip, Never> {
        return resultSubject.eraseToAnyPublisher()
    }

    private var cancellable = Set<AnyCancellable>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        observe()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func observe() {
        self.resultSubject.sink { [weak self] resultTip in
            self?.configure(result: resultTip)
        }.store(in: &cancellable)
    }

    func configure(result: ResultTip) {

        // total p/person
        let personPerTotalBill = NSMutableAttributedString.init(string: "$\(result.totalBillPerPerson)", attributes: [.font: AppFont.bold(ofSize: 48)])
        personPerTotalBill.addAttributes([ .font : AppFont.bold(ofSize: 30) ], range: NSMakeRange(0, 1))
        self.billLabel.attributedText = personPerTotalBill

        self.totalBillView.configure(amount: result.totalBill)

        self.totalTipView.configure(amount: result.totalTip)
    }

    private func layout() {

        backgroundColor = .white

        self.snp.makeConstraints { make in
            make.height.equalTo(224)
        }

        addSubview(vStackView)

        vStackView.snp.makeConstraints { make in
            make.top.leading.equalTo(self).offset(24)
            make.bottom.trailing.equalTo(self).offset(-24)
        }

        separator.snp.makeConstraints { make in
            make.height.equalTo(2)
        }

        addShadow(
            offset: CGSize(width: 0, height: 3),
            color: UIColor.black,
            radius: 12.0,
            opacity: 0.1)

    }

    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }

    func reset() {
        self.resultSubject.send(ResultTip(totalBillPerPerson: 0, totalBill: 0, totalTip: 0))
    }


}

struct Result_Previews: PreviewProvider {
    static var previews: some View {

        ZStack {
            PreviewProviderForUIViewController(vc: CalculatorVC())
        }
        .ignoresSafeArea()

    }
}
