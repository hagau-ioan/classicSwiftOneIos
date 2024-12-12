//
//  CustomNavigationController.swift
//  ClassicSwiftOne
//
//  Created by Ioan Hagau on 26.08.2024.
//

import UIKit
import SwiftUI

struct CustomNavigationBar: UIViewControllerRepresentable {

    var build: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<CustomNavigationBar>) -> UIViewController {
        return UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CustomNavigationBar>) {
        if let navigationController = uiViewController.navigationController {
            self.build(navigationController)
        }
    }
}

