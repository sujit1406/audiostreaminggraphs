//
//  ContentView.swift
//  RadioStreamingTimeCalculator
//
//  Created by Sujith Antony on 04/09/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var sessionListVM = StreamingListViewModel()
    
    init() {
        sessionListVM.load()
    }
    var body: some View {
        VStack {
            Text("Effective Streaming Time")
                .font(.custom("Arial",size: 22))
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            Text(sessionListVM.formattedEffectiveStreamingTime())
                .font(.custom("Arial",size: 22))
                .fontWeight(.bold)
                .foregroundColor(Color.gray)
            StreamingListView(sessions: sessionListVM.streamingSessions)
            TimelineGraph(sessions:sessionListVM.streamingSessionGraphData())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
