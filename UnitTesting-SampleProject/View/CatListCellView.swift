//
//  CatListCellView.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-07-06.
//

import SwiftUI

struct CatListCellView: View {
    var model: CatBreedModel.CatListCellModel
    var body: some View {
        HStack(spacing: 16) {
            if let url = URL(string: model.url) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .background(.gray.opacity(0.2))
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                            .background {
                                Circle()
                                    .fill(.green)
                                    .frame(width: 82, height: 82)
                            }
                            .transition(.opacity.animation(.easeIn))
                    } else {
                        ProgressView()
                            .frame(width: 80, height: 80)
                    }
                }
                    
            }  else {
                Image(systemName: "heart.fill")
            }
            Text(model.name)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
        }
    }
}

struct CatListCellView_Previews: PreviewProvider {
    static var previews: some View {
        CatListCellView(model: .init(name: "Persian"))
    }
}
