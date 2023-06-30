//
//  ContentView.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-06-28.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CatViewModel()
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading")
                    .background(.ultraThinMaterial)
            } else {
                List {
                    ForEach($viewModel.cats, id: \.id) { cat in
                        Text(cat.name.wrappedValue ?? "")
                    }
                }
            }
        }
        .task {
            await viewModel.fetchCats()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
