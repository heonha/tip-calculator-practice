//
//  LogoView.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/02.
//

import UIKit
import Foundation
import SnapKit

class LogoView: UIView {

    let imageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "calculator")!
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    lazy var hStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 4
        let views = [imageView, vStackView]
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(48)
        }
        views.forEach { sv.addArrangedSubview($0) }

        return sv
    }()

    private let topLabel: UILabel = {
        let text = NSMutableAttributedString(string: "Mr TIP", attributes: [ .font : AppFont.regular()])
        text.addAttributes([ .font : AppFont.bold(size: 20) ], range: NSRange.init(location: 3, length: 3))

        let label = LabelFactory.build(
            attributedText: text,
            alignment: .center,
            font: AppFont.regular())

        return label
    }()

    private let bottomLabel: UILabel = {
        let label = LabelFactory.build(
            text: "Calculator",
            alignment: .center,
            font: AppFont.regular())

        return label
    }()

    private lazy var vStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 2
        sv.alignment = .leading




        let labels = [topLabel, bottomLabel]
        labels.forEach { sv.addArrangedSubview($0) }

        return sv
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(hStackView)
        layout()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(48)
        }

        hStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

}
