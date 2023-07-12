//
//  FormTextField+Modifier.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-07-12.
//

import SwiftUI

struct FormTextField: ViewModifier {
    var isFocused: Bool = false
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(.gray.opacity(0.2))
            .background {
                Capsule().stroke(style: .init(lineWidth: isFocused ? 1 : 0))
            }
            .containerShape(Capsule())
            .foregroundColor(.black)
            .font(.system(size: 20))
    }
}
