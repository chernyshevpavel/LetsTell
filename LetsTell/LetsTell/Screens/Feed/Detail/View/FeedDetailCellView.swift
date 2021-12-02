//
//  FeedDetailCellView.swift
//  LetsTell
//
//  Created by Павел Чернышев on 19.04.2021.
//

import SwiftUI

struct FeedDetailCellView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var step: StoryStep
    var paragraph: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Spacer()
            }
            Text("§\(paragraph) • by \(step.author.name)")
                .font(.custom("SFPro-Regular", size: 16))
                .foregroundColor(colorScheme == .dark ?
                                    Color(customDarkModeColor: .subtitle) :
                                    Color(customColor: .secondGray))
            Text(step.text)
                .font(.custom("Merriweather-Regular", size: 15))
                .foregroundColor(colorScheme == .dark ?
                                    Color(customColor: .lightGray) :
                                    Color(customColor: .black))
                
        }
        .padding(.vertical, 14)
        .background(colorScheme == .dark ?
                Color(customDarkModeColor: .background) :
                Color(customColor: .generalText))
    }
}

struct FeedDetailCellView_Previews: PreviewProvider {

    static func getStep() -> StoryStep {
        StoryStep(ownRate: nil,
                  rate: 0,
                  rates: [],
                  id: "dd",
                  author: StoryCreator(id: "", name: "AVS2020", avatar: nil),
                  text: "Наверно кто-то ошибся номером, решила Ангелина и стала собираться на работу.\nВ лифте телефон ",
                  length: 492,
                  createdAt: "2020-10-09 19:35")
    }

    static var previews: some View {
        ForEach(["iPhone 11"], id: \.self) { _ in
            FeedDetailCellView(step: getStep(), paragraph: 1)
                   .environment(\.colorScheme, .dark)
            FeedDetailCellView(step: getStep(), paragraph: 1)
                .environment(\.colorScheme, .light)
        }
    }
}
