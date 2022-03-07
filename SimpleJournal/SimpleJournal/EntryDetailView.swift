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
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
