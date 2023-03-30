//
//  CustomPropertyWrappers.swift
//  ImageGalleryChallenge
//
//  Created by Danjuma Nasiru on 28/02/2023.
//

import SwiftUI

@propertyWrapper
struct NonNegative<Value: BinaryInteger> {
    var value: Value

    init(wrappedValue: Value) {
        if wrappedValue < 0 {
            value = 0
        } else {
            value = wrappedValue
        }
    }

    var wrappedValue: Value {
        get { value }
        set {
            if newValue < 0 {
                value = 0
            } else {
                value = newValue
            }
        }
    }
}

struct CustomPropertyWrappers: View {
    @State @NonNegative var score = -10
    
    var body: some View {
        Text("score: \(score)")
    }
}

struct CustomPropertyWrappers_Previews: PreviewProvider {
    static var previews: some View {
        CustomPropertyWrappers()
    }
}
