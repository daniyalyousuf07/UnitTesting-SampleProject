//
//  FormTextButton+Modifier.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-07-12.
//

import SwiftUI

struct FormTextButton: ViewModifier {
    
    var buttonDisabled: Bool = true
    func body(content: Content) -> some View {
        content
        .font(.system(size: 18))
        .fontWeight(.bold)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(buttonDisabled ? .gray.opacity(0.7) : .green)
        .foregroundColor(.white)
        .containerShape(RoundedRectangle(cornerRadius: 60))
    }
}
