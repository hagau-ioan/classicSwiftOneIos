//
//  MainContentView.swift
//  ClassicSwiftOne
//
//  Created by Ioan Hagau on 21.08.2024.
//

import SwiftUI

struct MainContentView: View {
    
    
    // NavigationSplitViewVisibility.detailOnly
    // NavigationSplitViewVisibility.all
    // NavigationSplitViewVisibility.automatic
    // NavigationSplitViewVisibility.all
    @State private var columnVisibility = NavigationSplitViewVisibility.automatic

    enum NavigationItem {
        case dashboard
        case dashboardSecond
        case test
    }
    
    @EnvironmentObject var viewmodel: MainViewModel
    
    @State private var selection: Set<NavigationItem> = [.dashboard]
    
    var body: some View {
    
//        LandscapeViewControllerWrapper()
//                    .edgesIgnoringSafeArea(.all)
        
        NavigationSplitView(columnVisibility: $columnVisibility) {
            sidebar
            .navigationTitle("Sidebar").toolbar(removing: .sidebarToggle)
        } content: {
            DetailsContentView().environmentObject(viewmodel)
                /*.navigationSplitViewColumnWidth(
                min: 150, ideal: 200, max: 400)*/
        } detail: {
            Text("Directly the details version")
            .navigationTitle("Details")
        }.navigationSplitViewStyle(.balanced)/*.navigationSplitViewColumnWidth(150)*/.onAppear(){
            //columnVisibility = .all
        }
    }
    
    var sidebar: some View {
        List(selection: $selection) { // (2)
            NavigationLink(destination: DetailsContentView().environmentObject(viewmodel) ) {
                Label("DASHBOARD", systemImage: "rectangle.3.offgrid.fill")
            }
            .accessibility(label: Text("Dashboard"))
            .tag(NavigationItem.dashboard)
            
            NavigationLink(destination: DetailsContentView().environmentObject(viewmodel) ) {
                Label("Second DASHBOARD", systemImage: "rectangle.3.offgrid.fill")
            }
            .accessibility(label: Text("Second Dashboard"))
            .tag(NavigationItem.dashboardSecond)
            NavigationLink(destination: Text("Hard Coded Content test")) {
                Label("Hard Coded Content", systemImage: "printer.fill.and.paper.fill")
            }
            .accessibility(label: Text("Hard Coded Content"))
            .tag(NavigationItem.test)
        }
        .listStyle(SidebarListStyle())
    }
    
}

#Preview {
    MainContentView()
}
