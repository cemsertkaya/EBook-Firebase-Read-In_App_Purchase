//
//  NetworkMonitor.swift
//  EBOOKAPP
//
//  Created by Cem Sertkaya on 18.02.2021.
//

import Foundation
import Network

final class NetworkMonitor
{
    static let shared = NetworkMonitor()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    enum ConnectionType
    {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init()
    {
        self.monitor = NWPathMonitor()
    }
    
    public func startMonitoring() -> Bool
    {
        monitor.start(queue: queue)
        var isConnectedBool = Bool()
        monitor.pathUpdateHandler = { [weak self] path in
            //self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
            if path.status == .satisfied
            {
                print("We're connected !")
                isConnectedBool = true
            }
            else
            {
                print("No connection.")
                isConnectedBool = false
            }
        }
        return isConnectedBool
    }
    
    public func stopMonitoring()
    {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath)
    {
        if path.usesInterfaceType(.wifi)
        {
            connectionType = .wifi
        }
        else if path.usesInterfaceType(.cellular)
        {
            connectionType = .cellular
        }
        else if path.usesInterfaceType(.wifi)
        {
            connectionType = .ethernet
        }
        else
        {
            connectionType = .unknown
        }
    }
}
