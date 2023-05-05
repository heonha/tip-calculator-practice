//
//  PreviewProviderForUIViewController.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/05.
//

import SwiftUI

struct PreviewProviderForUIViewController: UIViewControllerRepresentable {

    let vc: UIViewController

    init(vc: UIViewController) {
        self.vc = vc
    }

    func makeUIViewController(context: Context) -> UIViewController {
        return self.vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }


    typealias UIViewControllerType = UIViewController
}

