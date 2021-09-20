//
//  ContentView.swift
//  SOS
//
//  Created by Krzysztof Jankowski on 18/09/2021.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentView.ViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.titleText)
                .foregroundColor(.blue)
                .font(.title)
            Button(action: {
                viewModel.sendMessage()
            }, label: {
                Image(systemName: Constants.imageSystemName)
                    .padding()
                    .background(Color.blue)
                    .clipShape(Circle())
                    .font(.largeTitle)
                    .foregroundColor(.white)
            })
            Slider(
                value: $viewModel.sliderValue,
                in: 0.1...1,
                minimumValueLabel: Text("0"),
                maximumValueLabel: Text("1")
            ) {
                EmptyView()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentView.ViewModel())
    }
}
