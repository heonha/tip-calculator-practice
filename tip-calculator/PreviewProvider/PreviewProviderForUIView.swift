//
//  PreviewProviderForUIView.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/05.
//

import SwiftUI

struct PreviewProviderForUIView: UIViewRepresentable {

    var view: UIView

    init(view: UIView) {
        self.view = view
    }

    func makeUIView(context: Context) -> UIView {
        return self.view
    }

    func updateUIView(_ uiView: UIView, context: Context) {

    }

    typealias UIViewType = UIView


}
