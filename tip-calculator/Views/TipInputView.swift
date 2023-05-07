//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/02.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class TipInputView: UIView {

    let headerView = HeaderView(topTitle: "Choose", bottomTitle: "your tip")

    private lazy var tenPercentButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        button.tapPublisher
            .flatMap {
                Just(Tip.tenPercent)
            }
            .assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()

    private lazy var fiftenButton: UIButton = {
        let button = buildTipButton(tip: .fiftenPercent)
        button.tapPublisher
            .flatMap {
                Just(Tip.fiftenPercent)
            }
            .assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button

    }()

    private lazy var twentyPercentButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.tapPublisher
            .flatMap {
                Just(Tip.twentyPercent)
            }
            .assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button

    }()

    private lazy var customTipButton: UIButton = {
        let button = buildTipButton(tip: .custom(value: 0))
        return button
    }()

    private lazy var buttonContainerView: UIStackView = {
        let hStackView = UIStackView(arrangedSubviews: [tenPercentButton, fiftenButton, twentyPercentButton])
        hStackView.axis = .horizontal
        hStackView.distribution = .fillEqually
        hStackView.spacing = 8

        let vStackView = UIStackView(arrangedSubviews: [hStackView, customTipButton])
        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually
        vStackView.spacing = 8
        

        return vStackView
    }()

    private var tipSubject: CurrentValueSubject<Tip, Never> = .init(Tip.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func observe() {

    }

    private func layout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(56 + 56 + 8)
        }

        [headerView, buttonContainerView].forEach { addSubview($0) }

        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(tenPercentButton.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(buttonContainerView.snp.leading).offset(-24)
        }

        buttonContainerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }


    }

    private func buildTipButton(tip: Tip) -> UIButton {

        var attrString: NSMutableAttributedString
        if tip.stringValue.contains("%") {
            attrString = NSMutableAttributedString(string: tip.stringValue,
                                                   attributes: [
                                                    .font: AppFont.bold(ofSize: 20),
                                                    .foregroundColor: UIColor.white
                                                   ])
            attrString.addAttributes([.font: AppFont.regular(ofSize: 14)], range: NSMakeRange(2, 1))
        } else {
            attrString = NSMutableAttributedString(string: "Custom tip",
                                                   attributes: [
                                                    .font: AppFont.bold(ofSize: 20),
                                                    .foregroundColor: UIColor.white
                                                   ])
        }

        let button = UIButton()
        button.backgroundColor = AppColor.primary
        button.setAttributedTitle(attrString, for: .normal)
        button.addCornerRadius(radius: 8)

        return button
    }

}
