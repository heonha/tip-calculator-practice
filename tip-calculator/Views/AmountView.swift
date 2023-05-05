//
//  AmountView.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/05.
//

import UIKit
import SnapKit

class AmountView: UIView {

    private let title: String
    private let textAlignment: NSTextAlignment

    private lazy var titleLabel: UILabel = {
        LabelFactory.build(text: title, alignment: self.textAlignment, font: AppFont.regular(ofSize: 18))
    }()

    private lazy var amountLabel: UILabel = {
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [
                .font: AppFont.bold(ofSize: 24),
                    .foregroundColor: AppColor.primary
            ])
        text.addAttributes(
            [.font: AppFont.bold(ofSize: 16)],
            range: NSMakeRange(0, 1))

        let label = LabelFactory.build(
            attributedText: text,
            alignment: self.textAlignment)

        return label
    }()

    private lazy var vStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        sv.axis = .vertical

        return sv
    }()

    init(title: String, textAlignment: NSTextAlignment) {
        self.title = title
        self.textAlignment = textAlignment
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
