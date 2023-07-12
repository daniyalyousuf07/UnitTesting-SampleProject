//
//  ContentView.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-06-28.
//

import SwiftUI

struct ContentView: View {
    @Binding var presentScreen: Bool
    @StateObject var viewModel = CatViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading")
                } else {
                    List {
                        ForEach($viewModel.cats, id: \.id) { cat in
                            CatListCellView(model: cat.listCellModel.wrappedValue)
                        }
                    }
                }
            }
            .task {
                await viewModel.fetchCats()
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                       presentScreen = false
                    } label: {
                        Image(systemName: "chevron.backward")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }

                }
            })
            .navigationTitle("Cats")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(presentScreen: .constant(false))
    }
}
