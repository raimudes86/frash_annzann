//
//  testmodalApp.swift
//  testmodal
//
//  Created by 木下来夢 on 2024/09/13.
//

import SwiftUI

@main
struct testmodalApp: App {
    @StateObject var dataModel = DataModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataModel)
        }
    }
}
