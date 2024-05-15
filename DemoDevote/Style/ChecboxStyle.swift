//
//  ChecboxStyle.swift
//  DemoDevote2
//
//  Created by Aguid Ramirez Sanchez on 13/05/24.
//

import SwiftUI

struct ChecboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View{
        return HStack{
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
            
        } //: HSTACK
    }
}

#Preview {
    Toggle("Placeholder laberl", isOn: .constant(true))
        .toggleStyle(ChecboxStyle())
        .padding()
        .previewLayout(.sizeThatFits)
}
