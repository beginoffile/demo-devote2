//
//  ContentView.swift
//  DemoDevote
//
//  Created by Aguid Ramirez Sanchez on 18/04/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTY
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
    
    
    // MARK: - FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
   
    // MARK: - FUNCTIONS
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: - MAIN VIEW
                VStack {
                    //: MARK: . HEADER
                    
                    HStack(spacing: 30, content: {
                        // TITLE
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        Spacer()
                        // EDIT BUTTON
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal,10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2))
                        // APPEARANCE BUTTON
                        Button(action: {
                            // TOGGLE APPAREANCE
                            isDarkMode.toggle()
                        }, label: {
                            Image(systemName: isDarkMode ? "sun.max" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                    })
                    .padding()
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 80)
                    //: MARK: - NEW TASK BUTTON
                    Button(action: {
                        showNewTaskItem = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
                        .clipShape(Capsule())
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                   
                    List {
                        ForEach(items) { item in
//                            NavigationLink {
//                                
//                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                                
//                            } label: {
//                                // Text(item.timestamp!, formatter: itemFormatter)
//                                VStack(alignment: .leading){
//                                    Text(item.task ?? "")
//                                        .font(.headline)
//                                        .fontWeight(.bold)
//                                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                                        .font(.footnote)
//                                        .foregroundColor(.gray)
//                                }
//                            }
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    } //: LIST
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red:0, green:0, blue:0, opacity:0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
//                    .listRowBackground(Color.clear)
                } //: VSTACK
                
                // MARK: - NEW TASK ITEM
                if showNewTaskItem{
                    BlankView()
                        .onTapGesture {
                            withAnimation() {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            } //: ZTACK
            
            .navigationBarTitle("Daily Tasks", displayMode: .large)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                //                ToolbarItem(placement: .navigationBarTrailing) {
//                //                    Button(action: addItem) {
//                //                        Label("Add Item", systemImage: "plus")
//                //                    }
//                //                }
//            } //: TOOLBAR
            .navigationBarHidden(true)
            .background(
                BackgroundImageView()
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
        } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle()) // This is for Ipad like iphone
        
    }

   
}


// MARK: - PREVIEW
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
