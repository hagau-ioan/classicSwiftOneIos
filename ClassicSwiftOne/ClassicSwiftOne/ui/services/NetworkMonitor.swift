//
//  Network.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 17.05.2024.
//

import Foundation

import Network

class NetworkMonitor: ObservableObject {
    
    @Published var isConnected = false
    
    private var monitorNetwork = NWPathMonitor() // NWPathMonitor(requiredInterfaceType: .cellular) - only celluar
    
    init() {
        monitorNetwork.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        let queue = DispatchQueue(label: "Monitor")
        monitorNetwork.start(queue: queue)
    }
}
