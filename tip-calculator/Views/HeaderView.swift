//
//  HeaderView.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/05.
//

import UIKit

class HeaderView: UIView {

    private let topTitle: String
    private let bottomTitle: String

    private lazy var topLabel = LabelFactory.build(text: topTitle, font: AppFont.bold(ofSize: 17))
    private lazy var bottomLabel = LabelFactory.build(text: bottomTitle, font: AppFont.regular(ofSize: 17))

    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()

    private lazy var hStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            topSpacerView,
            topLabel,
            bottomLabel,
            bottomSpacerView
        ])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .leading
        sv.spacing = -4

        return sv
    }()


    init(topTitle: String, bottomTitle: String) {
        self.topTitle = topTitle
        self.bottomTitle = bottomTitle
        super.init(frame: .zero)

        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        addSubview(hStackView)
        hStackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        topSpacerView.snp.makeConstraints { make in
            make.height.equalTo(bottomSpacerView)
        }
    }

    func configure(topText: String, bottomText: String) {
        topLabel.text = topText
        bottomLabel.text = bottomText
    }

}
