//
//  LandscapeViewControllerWrapper.swift
//  ClassicSwiftOne
//
//  Created by Ioan Hagau on 26.08.2024.
//

import SwiftUI

struct LandscapeViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LandscapeViewController {
        return LandscapeViewController()
    }
    
    func updateUIViewController(_ uiViewController: LandscapeViewController, context: Context) {
        // Update the view controller if needed
    }
}
