//
//  HideKeyboardExtension.swift
//  DemoDevote
//
//  Created by Aguid Ramirez Sanchez on 29/04/24.
//

import SwiftUI

#if canImport(UIKit)
extension View{
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


