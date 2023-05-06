//
//  SplitInputView.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/02.
//

import UIKit
import SnapKit

class SplitInputView: UIView {

    private let headerView = HeaderView(topTitle: "Split", bottomTitle: "the total")

    var score: Int = 1

    private lazy var minusButton = buildSplitButton(title: "-")
    private lazy var plusButton = buildSplitButton(title: "+")
    private lazy var scoreLabel: UILabel = LabelFactory.build(text: "\(score)", font: AppFont.bold(ofSize: 20))

    private lazy var hStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [minusButton, scoreLabel, plusButton])
        sv.axis = .horizontal
        sv.backgroundColor = AppColor.primary
        sv.addCornerRadius(radius: 8)

        scoreLabel.backgroundColor = .white

        minusButton.snp.makeConstraints { make in
            make.width.equalTo(68)
        }

        plusButton.snp.makeConstraints { make in
            make.width.equalTo(68)
        }


        return sv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        [headerView, hStackView].forEach { addSubview($0) }

        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(hStackView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(hStackView.snp.leading).offset(-24)
        }

        hStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
    }

    private func buildSplitButton(title: String) -> UIButton {

        let attrString = NSMutableAttributedString(string: title,
                                               attributes: [
                                                .font: AppFont.bold(ofSize: 36),
                                                .foregroundColor: UIColor.white
                                               ])
        let button = UIButton()
        button.setAttributedTitle(attrString, for: .normal)

        return button
    }

}
