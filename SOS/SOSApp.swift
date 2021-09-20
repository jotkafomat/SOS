//
//  SOSApp.swift
//  SOS
//
//  Created by Krzysztof Jankowski on 18/09/2021.
//

import SwiftUI

@main
struct SOSApp: App {
    
    @StateObject var viewModel = ContentView.ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
