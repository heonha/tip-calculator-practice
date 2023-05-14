//
//  SplitInputView.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/02.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class SplitInputView: UIView {

    private let headerView = HeaderView(topTitle: "Split", bottomTitle: "the total")

    private var score: Int = 1

    private var cancellable = Set<AnyCancellable>()

    private lazy var minusButton = {
        let button = buildSplitButton(title: "-")
        button.tapPublisher.flatMap { [unowned self] _ in
            Just(self.splitSubject.value == 1 ? 1 : self.splitSubject.value - 1 )
        }
        .assign(to: \.value, on: splitSubject)
        .store(in: &cancellable)

        return button
    }()

    private lazy var plusButton = {
        let button = buildSplitButton(title: "+")
        button.tapPublisher.sink { [unowned self] _ in
            let score = splitSubject.value + 1
            self.splitSubject.send(score)
        }.store(in: &cancelables)

        return button
    }()

    private lazy var scoreLabel: UILabel = {
        let label = LabelFactory.build(text: "\(splitSubject.value)",
                                       font: AppFont.bold(ofSize: 20))

        self.splitPublisher.sink { [unowned self] score in
            label.text = score.stringValue
        }.store(in: &cancelables)

        return label
    }()



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

    private var splitSubject: CurrentValueSubject<Int, Never> = .init(1)
    var splitPublisher: AnyPublisher<Int, Never> {
        return splitSubject
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    private var cancelables = Set<AnyCancellable>()

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


    func reset() {
        self.splitSubject.send(1)
    }

}
