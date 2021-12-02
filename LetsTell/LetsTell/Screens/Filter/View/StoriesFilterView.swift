//
//  StoriesFilterView.swift
//  LetsTell
//
//  Created by Павел Чернышев on 18.05.2021.
//

import SwiftUI

struct StoriesFilterView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appManager: ApplicationManager
    
    @StateObject var controller = StoriesFilterViewController()
    @Binding var presented: Bool
    
    var chengedFiltersApplying: () -> Void
    
    var filterSections: [FilterSectionModel] {
        controller.filters
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Reset", action: {
                    controller.resetFilters()
                })
                
                Spacer()
                
                Text("Filters")
                    .font(.headline)
                
                Spacer()
                
                Button("Cancle", action: {
                    presented = false
                })
            }
            .foregroundColor(colorScheme == .dark ? Color(customColor: .generalText) : .black)
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 10)
            .background(colorScheme == .dark ? Color(customColor: .navBarModalStackDark) : Color(.clear))
            
            ZStack {
                List {
                    ForEach(filterSections) { section in
                        Section(header:
                                    VStack {
                                        Text(section.name)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                    }
                        ) {
                            ForEach(section.rows) { filter in
                                StoriesFilterRowView(filter: filter, filterType: section.id, onCheckMarkTap: { [weak controller] model, filterType in
                                    controller?.onCheckMarkTap(model: model, filterType: filterType)
                                })
                            }
                        }
                        .textCase(.none)
                    }
                    Spacer(minLength: 10)
                       .listRowBackground(colorScheme == .dark ? Color(customColor: .additionBackground) : Color(.white))
                }
                .onAppear(perform: {
                    let tableBgColor = getTableBackgrountColor()
                    UITableViewCell.appearance().backgroundColor = tableBgColor
                    UITableView.appearance().backgroundColor = tableBgColor
                })
                
                VStack {
                    Spacer()
                    
                    BaseButton(action: {
                        controller.apply()
                        presented = false
                    }, text: Text("Apply").fontWeight(.none))
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
                
                if controller.currentlyLoading {
                    VStack {
                        HStack {
                            ProgressView()
                        }
                    }
                }
            }
            Spacer()
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(colorScheme == .dark ? Color(customColor: .navBarModalStackDark) : Color(.clear))
        .alert(isPresented: .constant(!self.controller.errorMessage.isEmpty), content: {
            Alert(
                title: Text("Error")
                    .foregroundColor(Color.red),
                message: Text("\(self.controller.errorMessage)")
                    .foregroundColor(.red),
                dismissButton: .default(Text("Ok"), action: {
                    self.controller.errorMessage = ""
                })
            )
        })
        .onAppear(perform: {
            controller.chengedFiltersApplying = chengedFiltersApplying
            controller.setup(container: appManager)
            controller.loadFilters()
        })
    }
    
    private func getTableBackgrountColor() -> UIColor {
        let tableBackgroundColor = colorScheme == .dark ? Color(customColor: .additionBackground) : Color(.white)
        let tableBackgroundUIColor = UIColor(cgColor: tableBackgroundColor.cgColor ?? CGColor(red: 0, green: 0, blue: 0, alpha: 0))
        return tableBackgroundUIColor
    }
}

struct StoriesFilterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StoriesFilterView(presented: .constant(true), chengedFiltersApplying: {}).environment(\.colorScheme, .dark)
            StoriesFilterView(presented: .constant(true), chengedFiltersApplying: {})
        }
    }
}
