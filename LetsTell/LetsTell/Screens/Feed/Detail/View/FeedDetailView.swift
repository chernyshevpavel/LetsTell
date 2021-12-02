//
//  FeedDetailView.swift
//  LetsTell
//
//  Created by Павел Чернышев on 19.04.2021.
//

import SwiftUI

struct FeedDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appManager: ApplicationManager
    @StateObject var feedDetailViewController = FeedDetailViewController()
    @State var story: Story
    
    var feedSteps: [StoryStep] {
        feedDetailViewController.steps
    }
    
    let height: CGFloat = 10
    var screenPading = EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32)
    @State private var selectedNumber = 0
    
    var body: some View {
        GeometryReader { _ in
            NavigationView {
                VStack {
                    ZStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack {
                                ForEach(feedSteps) { step in
                                    FeedDetailCellView(step: step, paragraph: feedDetailViewController.getIndexForStep(step: step))
                                        .environment(\.colorScheme, colorScheme)
                                }
                                
                                if !feedSteps.isEmpty {
                                    if story.statusID == 3 {
                                        Text("This story is over let's start a new one!")
                                            
                                            .font(.custom("Merriweather-Regular", size: 13, relativeTo: .caption2))
                                            .fontWeight(.light)
                                            .frame(idealWidth: .infinity, maxWidth: .infinity, minHeight: 55.0)
                                            .overlay(RoundedRectangle(cornerRadius: 14)
                                                        .stroke(Color(.clear), lineWidth: 0))
                                            .foregroundColor(Color(customDarkModeColor: .whiteGray))
                                            .background(Color(customColor: .secondGray))
                                            .cornerRadius(14)
                                            
                                            .foregroundColor( colorScheme == .dark ? Color(customDarkModeColor: .whiteGray) : Color(customColor: .secondGray))
                                        
                                        Spacer()
                                            .frame(minHeight: 5, idealHeight: 40, maxHeight: 40)
                                        
                                        BaseButton(action: { }, text: Text("BEGIN A NEW STORY"))
                                            .padding(.bottom, 50.0)
                                            .font(.custom("SFPro-Regular", size: 16))
                                    } else {
                                        Text("To be continued...")
                                            .font(.custom("Merriweather-Regular", size: 13, relativeTo: .caption2))
                                            .fontWeight(.light)
                                            .frame(idealWidth: .infinity, maxWidth: .infinity, minHeight: 55.0)
                                            .overlay(RoundedRectangle(cornerRadius: 14)
                                                        .stroke(Color(.clear), lineWidth: 0))
                                            .foregroundColor(Color(customDarkModeColor: .whiteGray))
                                            .background(Color(customColor: .secondGray))
                                            .cornerRadius(14)
                                    }
                                }
                            }
                        }
                        .padding(screenPading)
                        .background(colorScheme == .dark ?
                                        Color(customDarkModeColor: .background) :
                                        Color(customColor: .generalText))
                        .navigationTitle(story.title)
                        .navigationBarTitleDisplayMode(.inline)
                        
                        if feedSteps.isEmpty {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle(story.title)
        }
        .edgesIgnoringSafeArea(.all)
        .background(colorScheme == .dark ?
                        Color(customDarkModeColor: .background) :
                        Color(customColor: .generalText))
        .onAppear(perform: {
            feedDetailViewController.setup(container: appManager)
            feedDetailViewController.loadSteps(story: story)
        })
        .alert(isPresented: .constant(!self.feedDetailViewController.error.isEmpty), content: {
            Alert(
                title: Text("Error")
                    .foregroundColor(Color.red),
                message: Text("\(self.feedDetailViewController.error)")
                    .foregroundColor(.red),
                dismissButton: .default(Text("Ok"), action: {
                    self.feedDetailViewController.error = ""
                })
            )
        })
    }
}

struct FeedDetailView_Previews: PreviewProvider {
    static func getFeedDetailViewController() -> FeedDetailViewController {
        let feedVC = FeedDetailViewController()
        feedVC.steps = [
            StoryStep(ownRate: nil,
                      rate: 1,
                      rates: [],
                      id: "1",
                      author: StoryCreator(id: "1", name: "Pavel", avatar: nil),
                      text: "Welcome to the new world of story tell",
                      length: "Welcome to the new world of story tell".count,
                      createdAt: "2021-04-20 23:10"),
            
            StoryStep(ownRate: nil,
                      rate: 1,
                      rates: [],
                      id: "1",
                      author: StoryCreator(id: "3", name: "Pavel", avatar: nil),
                      text: "Todo Violation: TODOs should be resolved ",
                      length: "Todo Violation: TODOs should be resolved ".count,
                      createdAt: "2021-04-21 23:40")
        ]
        return feedVC
    }
    
    static var feedRespnse = ModelData().feedResponse
    
    private static func getStory() -> Story {
        var story = feedRespnse.body[6]
        story.image = UIImage(named: "fb")
        return story
    }
    
    private static func getStatusID() -> Story {
        feedRespnse.body[6]
    }
    
    static var previews: some View {
        FeedDetailView(story: getStory())
            .environmentObject(UserAuthManager())
            .environment(\.colorScheme, .light)
    }
}
