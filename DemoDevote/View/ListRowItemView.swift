//
//  ListRowItemView.swift
//  DemoDevote2
//
//  Created by Aguid Ramirez Sanchez on 10/05/24.
//

import SwiftUI

struct ListRowItemView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var item: Item
    
    var body: some View {
        Toggle(isOn: $item.completion){
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? Color.pink : Color.primary)
                .padding(.vertical, 12)
                
        } //: TOGGLE
        .toggleStyle(ChecboxStyle())
        .onReceive(item.objectWillChange, perform: { _ in
            if self.viewContext.hasChanges{
                try? self.viewContext.save()
            }
        })
    }
}

//#Preview {
//    var item : Item
//    return ListRowItemView(item: item)
//}
