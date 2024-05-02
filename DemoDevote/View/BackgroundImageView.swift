//
//  BackgroundImageView.swift
//  DemoDevote
//
//  Created by Aguid Ramirez Sanchez on 01/05/24.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

#Preview {
    BackgroundImageView()
}
