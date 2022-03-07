//
//  EntryDetailView.swift
//  SimpleJournal
//
//  Created by WEI XIE on 2022-03-06.
//

import SwiftUI
import CoreData


struct EntryDetailView: View {
    var item: Item?

    @State private var content: String = ""
    @State private var selectedDate = Date()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    init(item:Item?) {
        _content = State(initialValue: item?.content ?? "")
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .center) {
            DatePicker("", selection: $selectedDate, displayedComponents: .date).datePickerStyle(CompactDatePickerStyle()).labelsHidden()
            TextField("Today was...", text: $content)
                .padding()
            Spacer()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    //
                    if let item = item {
                        item.content = content
                        do {
                            let viewContext = PersistenceController.shared.container.viewContext
                            try viewContext.save()
                        } catch {
                            // Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .padding()
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var viewContext = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        let sampleItem = Item(context: viewContext)
        let date = Date()
        sampleItem.timestamp = date
        sampleItem.content = "This is a random content, Yes. This is a random content, Yes. This is a random content, Yes."
        return EntryDetailView(item: sampleItem).environment(\.managedObjectContext, viewContext)
        
    }
}
