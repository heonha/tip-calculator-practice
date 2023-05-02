//
//  ResultView.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/02.
//

import UIKit

class ResultView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        self.backgroundColor = .yellow
        self.snp.makeConstraints { make in
            make.height.equalTo(224)
        }
    }

}
