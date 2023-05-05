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

    // ImageView
    let logoImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "calculator") ?? UIImage()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    // Labels
    private let topLabel: UILabel = {
        let text = NSMutableAttributedString(string: "Mr TIP", attributes: [ .font : AppFont.regular()])
        text.addAttributes([ .font : AppFont.bold(ofSize: 24) ], range: NSRange.init(location: 3, length: 3))

        let label = LabelFactory.build(
            attributedText: text,
            alignment: .center)

        return label
    }()

    private let bottomLabel: UILabel = {
        let label = LabelFactory.build(
            text: "Calculator",
            alignment: .center,
            font: AppFont.regular())

        return label
    }()


    // Stacks
    lazy var hStackView = {
        let sv = UIStackView(arrangedSubviews: [logoImageView, vStackView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 4

        logoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(48)
        }

        return sv
    }()


    private lazy var vStackView = {
        let sv = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 2
        sv.alignment = .leading

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
