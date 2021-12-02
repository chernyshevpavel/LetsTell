//
//  FeedView.swift
//  LetsTell
//
//  Created by Павел Чернышев on 26.03.2021.
//

import SwiftUI
import UIKit

struct FeedView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appManager: ApplicationManager
    
    @StateObject var feedViewController: FeedViewController
    @StateObject var applyedFiltersObserver = ApplyedFiltersObserver()
    
    @State private var isFilterPresented = false
    
    var feedStories: [Story] {
        feedViewController.stories
    }
    
    let height: CGFloat = 10
    var screenPading = EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    
    @State private var showDetail = false
    @State private var selectedNumber = 0
    
    var body: some View {
        GeometryReader { _ in
            NavigationView {
                VStack {
                    ZStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            RefreshControl(coordinateSpace: .named("pullToRefresh"), isRefreshing: $feedViewController.currentlyRefreshing) {
                                feedViewController.refreshFeed()
                            }
                            ScrollViewReader { value in
                                LazyVStack {
                                    ForEach(feedStories, id: \.self) { story in
                                        FeedCellView(story: story, marginEdgeInserts: screenPading)
                                            .onAppear(perform: {
                                                feedViewController.onStoryAppear(story: story)
                                            })
                                    }
                                }
                                .onAppear(perform: {
                                    feedViewController.scrollToTop = {
                                        if let story = feedStories.first {
                                            withAnimation {
                                                value.scrollTo(story, anchor: .top)
                                            }
                                        }
                                    }
                                })
                                
                                if feedViewController.currentlyLoading && !feedStories.isEmpty {
                                    ProgressView()
                                        .padding()
                                }
                            }
                        }
                        .coordinateSpace(name: "pullToRefresh")
                        .padding(screenPading)
                        .background(colorScheme == .dark ?
                                        Color(customDarkModeColor: .background) :
                                        Color(customColor: .generalText))
                        .navigationBarItems(
                            leading: Text("New"),
                            trailing: HStack {
                                Button(action: {
                                    isFilterPresented.toggle()
                                }, label: {
                                    if applyedFiltersObserver.hasActiveFilters {
                                        Label("", image: "sliders")
                                            .frame(width: 21, height: 26, alignment: .center)
                                            .padding(.horizontal, 2)
                                            .background(colorScheme == .dark ? Color(customColor: .yellow) : Color(customColor: .gray5))
                                            .cornerRadius(15)
                                            .overlay(
                                                VStack(alignment: .trailing) {
                                                    HStack {
                                                        Spacer()
                                                    
                                                        Circle()
                                                            .frame(width: 8, height: 8, alignment: .center)
                                                            .foregroundColor(.red)
                                                        Spacer().frame(width: 1, height: 0)
                                                    }
                                                    Spacer()
                                                }
                                            )
                                    } else {
                                        Label("", image: "sliders")
                                            .frame(width: 21, height: 26, alignment: .center)
                                            .padding(.horizontal, 2)
                                            .background(colorScheme == .dark ? Color(customColor: .yellow) : Color(customColor: .gray5))
                                            .cornerRadius(15)
                                            
                                    }
                                })
                                .sheet(isPresented: $isFilterPresented,
                                       onDismiss: { isFilterPresented = false },
                                       content: {
                                        StoriesFilterView.init(
                                            presented: $isFilterPresented,
                                            chengedFiltersApplying: {
                                                applyedFiltersObserver.check()
                                                feedViewController.loadFeed(filtersApplying: true)
                                            })
                                       })
                            })
                        .navigationBarTitleDisplayMode(.inline)
                        
                        if feedViewController.currentlyFiltersApplying {
                            ZStack {
                                ProgressView()
                            }
                            .frame(width: 40, height: 40, alignment: .center)
                            .background(Color(.black).opacity(0.3))
                        } else if feedStories.isEmpty && feedViewController.currentlyLoading {
                            ProgressView()
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(colorScheme == .dark ?
                        Color(customDarkModeColor: .background) :
                        Color(customColor: .generalText))
        .onAppear(perform: {
            applyedFiltersObserver.setup(container: appManager)
            applyedFiltersObserver.check()
            
            UINavigationBar.appearance().barTintColor = UIColor(colorScheme == .dark ?
                                                                    Color(customDarkModeColor: .background) :
                                                                    Color(customColor: .generalText))
            UINavigationBar.appearance().backgroundColor = UIColor(colorScheme == .dark ?
                                                                    Color(customDarkModeColor: .background) :
                                                                    Color(customColor: .generalText))
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().shadowImage = UIImage()
        })
        .alert(isPresented: .constant(!self.feedViewController.error.isEmpty), content: {
            Alert(
                title: Text("Error")
                    .foregroundColor(Color.red),
                message: Text("\(self.feedViewController.error)")
                    .foregroundColor(.red),
                dismissButton: .default(Text("Ok"), action: {
                    self.feedViewController.error = ""
                })
            )
        })
    }
}

struct FeedViewPreviews: PreviewProvider {
    
    static func getFeedVC() -> FeedViewController {
        let feedVC = FeedViewController()
        feedVC.stories = ModelData().feedResponse.body
        return feedVC
    }
    
    static var previews: some View {
        ForEach(["iPhone 11"], id: \.self) { _ in
            FeedView(feedViewController: getFeedVC())
                .environment(\.colorScheme, .light)
                .environmentObject(ModelData())
                .environmentObject(UserAuthManager())
                .environmentObject(ApplicationManager(false))
            FeedView(feedViewController: getFeedVC())
                .environment(\.colorScheme, .dark)
                .environmentObject(ModelData())
                .environmentObject(UserAuthManager())
                .environmentObject(ApplicationManager(false))
        }
        
    }
}
