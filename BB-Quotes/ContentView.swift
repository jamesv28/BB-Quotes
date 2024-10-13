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
            QuoteView(show: "Breaking Bad")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("Breaking Bad", systemImage: "tortoise")
                }
            QuoteView(show: "Better Call Saul")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("Better Call Saul", systemImage: "briefcase")
                }
            QuoteView(show: "El Camino")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("El Camino", systemImage: "car")
                }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
