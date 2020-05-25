//
//  SpeedView.swift
//  Fietscomputer
//
//  Created by Grigory Avdyushin on 30/04/2020.
//  Copyright © 2020 Grigory Avdyushin. All rights reserved.
//

import SwiftUI
import PageView
import SplitView

struct ContentView: View {

    @ObservedObject var sliderViewModel = SliderControlViewModel(middle: 0.5, range: 0.3...0.85)
    @ObservedObject var contentViewModel: ContentViewModel

    @State private var pageIndex: Int = 0

    var body: some View {
        GeometryReader { geometry in
            SplitView(
                viewModel: self.sliderViewModel,
                controlView: {
                    Rectangle()
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(minWidth:0, maxWidth: .infinity, minHeight: 6, maxHeight: 6)
                        .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: -5)
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color(UIColor.separator))
                        .frame(width: 48, height: 3)
                },
                topView: { MapView(viewModel: self.contentViewModel.mapViewModel) },
                bottomView: {
                    VStack {
                        PageView(index: self.$pageIndex, modifierType: PageIndicatorDefaultModifier.self) {
                            PageContentView(indicator: { Text("Speed") }) {
                                AnyView(VStack {
                                    SpeedView(viewModel: self.contentViewModel.speedViewModel).frame(minHeight: 0, maxHeight: .infinity)
                                    HStack {
                                        GaugeView(viewModel: self.contentViewModel.durationViewModel).frame(minWidth: 0, maxWidth: .infinity)
                                        GaugeView(viewModel: self.contentViewModel.distanceViewModel).frame(minWidth: 0, maxWidth: .infinity)
                                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 18, trailing: 0))
                                })
                            }
                            PageContentView(indicator: { Text("Distance") }) {
                                AnyView(Group {
                                    Text("TODO Page2")
                                })
                            }
                        }
                        Button(action: self.contentViewModel.startPauseRide) {
                            Text(self.contentViewModel.buttonTitle)
                        }
                        .foregroundColor(.green)
                        .buttonStyle(ActionButtonStyle())
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: geometry.safeAreaInsets.bottom, trailing: 0))
                        .background(Color.green)
                    }
                    .background(Color(UIColor.systemBackground))
                }
            )
        }.edgesIgnoringSafeArea([.horizontal, .bottom])
    }
}
