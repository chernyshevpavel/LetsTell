//
//  FeedFilterRowView.swift
//  LetsTell
//
//  Created by Павел Чернышев on 18.05.2021.
//

import SwiftUI

struct StoriesFilterRowView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var filter: FilterModel
    var filterType: FiltersType
    var onCheckMarkTap: (FilterModel, FiltersType) -> Void
    
    var body: some View {
        HStack {
            Text(filter.name)
            Spacer()
            Image(systemName: filter.active ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 22, height: 22)
                .foregroundColor(
                    filter.active
                        ? (colorScheme == .dark ? Color(customColor: .yellow) : Color(customDarkModeColor: .background))
                        : (colorScheme == .dark ? Color(customColor: .navBarModalStackDark) : Color.secondary))
                .onTapGesture {
                    self.onCheckMarkTap(filter, filterType)
                }
        }
        .listRowBackground(colorScheme == .dark ? Color(customColor: .additionBackground) : Color(.white))
        .padding(.vertical, 5)
    }
}

struct StoriesFilterRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StoriesFilterRowView(filter: FilterModel(id: 0, name: "Hello, World!!"), filterType: .ganre) { _, _ in }
            StoriesFilterRowView(filter: FilterModel(id: 0, name: "Hello, World!!"), filterType: .ganre, onCheckMarkTap: { _, _ in })
            StoriesFilterRowView(filter: FilterModel(id: 0, name: "Hello, World!!", active: true), filterType: .ganre, onCheckMarkTap: { _, _ in }).environment(\.colorScheme, .dark)
            StoriesFilterRowView(filter: FilterModel(id: 0, name: "Hello, World!!"), filterType: .ganre, onCheckMarkTap: { _, _ in }).environment(\.colorScheme, .dark)
        }
        .previewLayout(.fixed(width: 300, height: 70))
        
    }
}
