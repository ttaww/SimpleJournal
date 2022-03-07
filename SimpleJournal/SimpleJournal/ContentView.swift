//
//  ContentView.swift
//  SimpleJournal
//
//  Created by Tingting on 2022-03-06.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var selection: Int? = nil
    @State var stateId = UUID()
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity:Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        EntryDetailView(item: item)
                    } label: {
                        HStack {
                            VStack {
                                Text("\(getMonth(date:item.timestamp))")
                                    .font(.title)
                                    .frame(width: 100)
                                    .padding(.leading, -20)
                                Text("\(getDay(date:item.timestamp)) ")
                                    .foregroundColor(.red)
                                    .font(.title)
                                    .frame(width: 50)
                                    .padding(.leading, -20)
                            }
                            Text(item.content ?? "")
                                .font(.system(size: 14))
                        }  
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink(destination:EntryDetailView(item: nil),
                                   tag: 1,
                                   selection: $selection){
                        Button(action: {
                            self.selection = 1
                        }) {
                            Label("Add Item", systemImage: "square.and.pencil")
                        }
                    }
                }
                
            }
        }.onAppear {
            stateId = UUID()
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.content = "Temp String Temp String Temp String Temp String Temp String Temp String Temp String Temp String Temp String Temp String Temp String Temp String Temp String "
            
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
    
    private func getMonth(date:Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        if let dateToBeFormatted = date {
            let month = formatter.string(from: dateToBeFormatted)
            return month.uppercased()
        }
        return ""
    }
    
    private func getDay(date:Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        if let dateToBeFormatted = date {
            let day = formatter.string(from: dateToBeFormatted)
            return day
        }
        return ""
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
