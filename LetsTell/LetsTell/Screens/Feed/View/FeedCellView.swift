//
//  FeelCellView.swift
//  LetsTell
//
//  Created by Павел Чернышев on 02.04.2021.
//

import SwiftUI

struct FeedCellView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var story: Story
    var padingEdgeInserts = EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
    var marginEdgeInserts: EdgeInsets
    var iphoneXImageSize = CGSize(width: 325, height: 180)
    
    @State private var imageHeight: CGFloat?
    @State private var imageWidth: CGFloat?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(story.title) • \(story.genre.name)")
                    .font(.custom("SFPro-Regular", size: 17))
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? Color(customDarkModeColor: .whiteGray) : Color(customColor: .black))
            }
            .padding(.bottom, 1)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("§\(story.steps) by \(story.lastStep.author.name) • \(story.lastStep.createdAt)")
                        .font(.custom("SFPro-Regular", size: 16))
                        .foregroundColor(colorScheme == .dark ? Color(customDarkModeColor: .subtitle) : Color(customColor: .black))
                }
                
                if let image = story.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: getImageWidth(),
                            height: getImageHeight(),
                            alignment: .center)
                        .clipped()
                        .cornerRadius(10)
                } else if story.coverFull != nil {
                    ZStack {
                        Image("background-image")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: getImageWidth(),
                                height: getImageHeight(),
                                alignment: .center)
                            .clipped()
                            .foregroundColor(.gray)
                        if story.isImageLoading {
                            ProgressView()
                        }
                    }
                }
                
                HStack {
                    Text(story.lastStep.text)
                        .font(.custom("Merriweather-Regular", size: 15))
                        .lineSpacing(3.5)
                        .foregroundColor(colorScheme == .dark ? Color(customDarkModeColor: .whiteGray) : Color(customColor: .black))
                    Spacer()
                }
                Divider()
                HStack {
                        Button(action: {}, label: {
                            NavigationLink(destination: FeedDetailView(story: story)) {
                                Label("Read", systemImage: "book")
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 5)
                                    .background(colorScheme == .dark ? Color(customDarkModeColor: .black) : Color(customColor: .generalText))
                                    .cornerRadius(8)
                            }
                        })
                    
                    Spacer()
                    if story.statusID != 3 {
                        Button(action: {}, label: {
                            Text("Continue Story")
                                .padding(.horizontal, 8)
                                .padding(.vertical, 5)
                                .background(colorScheme == .dark ? Color(customDarkModeColor: .black) :Color(customColor: .generalText))
                                .cornerRadius(8)
                        })
                    }
                }
            }
            .foregroundColor(colorScheme == .dark ? Color(customColor: .yellow) : Color(customColor: .secondGray))
            
        }
        .padding(padingEdgeInserts)
        .frame(maxWidth: .infinity)
        .background(colorScheme == .dark ? Color(customDarkModeColor: .cellGray) : Color(customColor: .lightGray))
        .cornerRadius(16)
    }
    
    private func getImageWidth() -> CGFloat {
        guard let imageWidth = self.imageWidth else {
            let xPading = padingEdgeInserts.leading + padingEdgeInserts.trailing
            let xMargin = marginEdgeInserts.leading + marginEdgeInserts.trailing
            let screenWidth = UIScreen.main.bounds.width
            let imageWidth = screenWidth - xMargin - xPading
            DispatchQueue.main.async {
                self.imageWidth = imageWidth
            }
            return imageWidth
        }
        return imageWidth
    }
    
    private func getImageHeight() -> CGFloat {
        guard let imageHeight = self.imageHeight else {
            let imageWidth = getImageWidth()
            let heightMultiplier = iphoneXImageSize.height / iphoneXImageSize.width
            let imageHeight = imageWidth * heightMultiplier
            DispatchQueue.main.async {
                self.imageHeight = imageHeight
            }
            return imageHeight
        }
        
        return imageHeight
    }
}

struct FeelCellView_Previews: PreviewProvider {
    static var feedRespnse = ModelData().feedResponse
    
    private static func getStory() -> Story {
        var story = feedRespnse.body[6]
        story.image = UIImage(named: "fb")
        return story
    }
    
    static var previews: some View {
        
        ForEach(["iPhone 11"], id: \.self) { _ in
            FeedCellView(
               story: getStory(),
               marginEdgeInserts: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                   .environment(\.colorScheme, .dark)
            FeedCellView(
               story: getStory(),
               marginEdgeInserts: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                   .environment(\.colorScheme, .light)
        }
    }
}
