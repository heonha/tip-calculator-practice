//
//  ResultView.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/02.
//

import UIKit
import SnapKit
import SwiftUI

class ResultView: UIView {


    private let headerLabel: UILabel = {
        return LabelFactory.build(text: "Total p/person", alignment: .center, font: AppFont.demiBold(ofSize: 18))
    }()

    private let billLabel: UILabel = {
        let text = NSMutableAttributedString.init(string: "$000", attributes: [.font: AppFont.bold(ofSize: 48)])
        text.addAttributes([ .font : AppFont.bold(ofSize: 30) ], range: NSMakeRange(0, 1))
        return LabelFactory.build(attributedText: text, alignment: .center)
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.separator
        return view
    }()

    private lazy var hStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            AmountView(title: "Total bill", textAlignment: .left),
            UIView(),
            AmountView(title: "Total tip", textAlignment: .right)
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


    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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


}

struct Result_Previews: PreviewProvider {
    static var previews: some View {

        ZStack {
            PreviewProviderForUIViewController(vc: CalculatorViewController())
        }
        .ignoresSafeArea()

    }
}
