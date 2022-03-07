//
//  EntryCell.swift
//  SimpleJournal
//
//  Created by WEI XIE on 2022-03-06.
//

import SwiftUI

struct EntryCell: View {
    var item: Item
    
    var body: some View {
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

struct EntryCell_Previews: PreviewProvider {
    static var viewContext = PersistenceController.preview.container.viewContext

    static var previews: some View {
        let sampleItem = Item(context: viewContext)
        let date = Date()
        sampleItem.timestamp = date
        sampleItem.content = "This is a random content, Yes. This is a random content, Yes. This is a random content, Yes."
        return EntryCell(item: sampleItem).environment(\.managedObjectContext, viewContext)

    }
}
