//
//  ContentView.swift
//  MoonshotIntroduction
//
//  Created by Marko Zivanovic on 23.6.22..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            Image("Minja")
                .resizable()
                //.scaledToFit()
                .scaledToFill()
                .frame(width: geo.size.width * 0.8, height: 300)
                .frame(width: geo.size.width, height: geo.size.height)
        
            //.clipped()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
  }
}
