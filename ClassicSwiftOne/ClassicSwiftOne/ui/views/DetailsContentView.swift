//
//  DetailsContentView.swift
//  ClassicSwiftOne
//
//  Created by Ioan Hagau on 26.08.2024.
//

import SwiftUI

struct DetailsContentView: View {
    
    @EnvironmentObject var viewModel: MainViewModel
    @State var counter: Int = 0
    
    /*
     * https://medium.com/@shashidj206/how-to-avoid-repeating-swiftui-view-updates-ec1fce0349a9
     * @Binding, @ObservedObject, or @EnvironmentObject and @State / @StateObject
     * @Binding: two-way connection between a property and its source of truth. usefull to transfer and observ changes between screen views.
     */
    var body: some View {
        // Avoid Unnecessary Work in View Builders: some View ....
        ZStack {
            Color(UIColor.baseGrey)
                .edgesIgnoringSafeArea(.all)

            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Text(viewModel.testing) // This will be refreshed when a change happen on it
                }.padding()
                    
            }
        }
        .navigationTitle(Text("Page Title: DetailsContentView screen"))
        .navigationBarTitleDisplayMode(.inline)
        .background(CustomNavigationBar { navigationController in
//            navigationController.navigationBar.backgroundColor =  UIColor.baseYellow
//            navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]
//            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: ThemeFonts.bold.rawValue, size: 24)!]
        }).onAppear {
            viewModel.test()
        }.onDisappear {
            
        }.onChange(of: counter) {
            // When counter is changed to something with it.
        }
    }
}

#Preview {
    DetailsContentView()
}
