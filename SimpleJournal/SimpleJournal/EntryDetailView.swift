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
    
    var body: some View {
        VStack(alignment: .center) {
            DatePicker("", selection: $selectedDate, displayedComponents: .date).datePickerStyle(CompactDatePickerStyle()).labelsHidden()
            TextField("Today was...", text: $content)
                .padding()
            Spacer()
        }.padding()
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
