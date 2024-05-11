//
//  NewTaskItemView.swift
//  DemoDevote2
//
//  Created by Aguid Ramirez Sanchez on 01/05/24.
//

import SwiftUI

struct NewTaskItemView: View {
    // MARK: - PROPERTIES
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var task: String = ""
    @Binding var isShowing: Bool
    
    private var isButtonDisable: Bool{
        task.isEmpty
    }
    
    // MARK: - FUNCTIONS
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task=""
            hideKeyboard()
            isShowing = false
        }
    }

    
    // MARK: - BODY
    
    var body: some View {
        VStack{
            Spacer()
            
            VStack(spacing: 16){
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) :  Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(10)
                Button(action: {
                    addItem()
                }, label: {
                    Spacer()
                    Text("Save")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                })
                .disabled(isButtonDisable)
                .padding()
                .foregroundColor(.white)
                .background(isButtonDisable ? Color.blue : Color.pink)
                .cornerRadius(10)
            } //: VSTACK
            .padding(.horizontal)
            .padding(.vertical,20)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
            )
            .cornerRadius(16)
            .shadow(color: Color(red:0, green:0, blue:0, opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
        } //: VSTACK
    }
}

#Preview {
    NewTaskItemView(isShowing: .constant(true))
}
