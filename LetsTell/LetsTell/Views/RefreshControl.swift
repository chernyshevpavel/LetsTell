//
//  RefreshControl.swift
//  LetsTell
//
//  Created by Павел Чернышев on 17.04.2021.
//

import SwiftUI

struct RefreshControl: View {
    var coordinateSpace: CoordinateSpace
    @Binding var isRefreshing: Bool
    var onRefresh: () -> Void
    var body: some View {
        ZStack {
        GeometryReader { geo in
            if geo.frame(in: coordinateSpace).midY > 50 {
                Spacer()
                    .onAppear {
                        if isRefreshing == false {
                            onRefresh()
                        }
                    }
            }
            ZStack(alignment: .center) {
                if isRefreshing {
                    ProgressView()
                } else {
                    ForEach(0..<8) { tick in
                        VStack {
                            Rectangle()
                                .fill(Color(UIColor.tertiaryLabel))
                                .opacity((Int((geo.frame(in: coordinateSpace).midY) / 7) < tick) ? 0 : 1)
                                .frame(width: 3, height: 7)
                                .cornerRadius(3)
                            Spacer()
                        }.rotationEffect(Angle.degrees(Double(tick) / (8) * 360))
                    }.frame(width: 20, height: 20, alignment: .center)
                }
            }.frame(width: geo.size.width)
        }.padding(.top, isRefreshing ? 0 : -50)
            if isRefreshing {
                Spacer()
                    .frame(width: 0, height: 50, alignment: .center)
            }
        }
    }
}
