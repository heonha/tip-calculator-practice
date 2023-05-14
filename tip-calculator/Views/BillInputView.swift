//
//  BillInputView.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/02.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class BillInputView: UIView {

    private let titleView = HeaderView(topTitle: "Enter", bottomTitle: "your bill")

    private let currencyDenominationLabel: UILabel = {
        let label = LabelFactory.build(text: "$", font: AppFont.bold(ofSize: 24))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return label
    }()

    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.font = AppFont.demiBold(ofSize: 28)
        tf.borderStyle = .none
        tf.keyboardType = .decimalPad
        tf.setContentHuggingPriority(.defaultLow, for: .horizontal)
        tf.tintColor = AppColor.text
        tf.textColor = AppColor.text
        tf.placeholder = ""
        tf.text = ""

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil),
            doneButton
        ]
        toolBar.isUserInteractionEnabled = true
        tf.inputAccessoryView = toolBar

        return tf
    }()

    private lazy var textFieldContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 8)
        return view
    }()

    private var cancellables = Set<AnyCancellable>()

    private var textFieldSubject = PassthroughSubject<Double, Never>()

    var textFieldPublisher: AnyPublisher<Double, Never> {
        return textFieldSubject.eraseToAnyPublisher()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        observe()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func observe() {
        textField.textPublisher.sink { [weak self] value in
            self?.textFieldSubject.send(value?.doubleValue ?? 0.0)
        }
        .store(in: &cancellables)

    }

    private func layout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        [titleView, textFieldContainer].forEach { addSubview($0) }

        titleView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(textFieldContainer.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(textFieldContainer.snp.leading).offset(-24)
        }

        textFieldContainer.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }

        textFieldContainer.addSubview(currencyDenominationLabel)
        textFieldContainer.addSubview(textField)

        currencyDenominationLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }

        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(currencyDenominationLabel.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    @objc private func doneButtonTapped() {
        textField.endEditing(true)
    }

    func reset() {
        self.textFieldSubject.send(0)
        self.textField.text = ""
    }

}

