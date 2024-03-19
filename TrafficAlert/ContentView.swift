//
//  ContentView.swift
//  TrafficAlert
//
//  Created by csuftitan on 3/17/24.
//

import SwiftUI
import GooglePlaces

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
