//
//  ContentView.swift
//  BB-Quotes
//
//  Created by James Volmert on 10/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            QuoteView(show: Constants.bbName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.bbName, systemImage: "tortoise")
                }
            QuoteView(show: Constants.bcsName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.bcsName, systemImage: "briefcase")
                }
            QuoteView(show: Constants.ecName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.ecName, systemImage: "car")
                }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
