//
//  StreamingListViewModel.swift
//  RadioStreamingTimeCalculator
//
//  Created by Sujith Antony on 04/09/24.
//

import Foundation

class StreamingListViewModel: ObservableObject {
    @Published var streamingSessions: [StreamingSessionViewModel] = []
    
    func load(){
        fetchSessions()
    }
    
    private func fetchSessions(){
        Webservice().getSessions() { streamingSessions in
            if let streamingSessions = streamingSessions {
                DispatchQueue.main.async {
                    self.streamingSessions = streamingSessions.map(StreamingSessionViewModel.init)
                }
            }
        }
    }
    
    func calculateEffectiveStreamingTime() -> TimeInterval {
        var effectiveTime:TimeInterval = 0
        for (index, session) in streamingSessions.enumerated() {
            if index == 0 {
                effectiveTime += session.endingTime - session.startingTime
            } else {
                var commonTime:TimeInterval = 0
                let previousSession = streamingSessions[index - 1]
                let currentSession = session
                if previousSession.endingTime > currentSession.startingTime {
                    commonTime = previousSession.endingTime - currentSession.startingTime
                }
                effectiveTime += currentSession.endingTime - currentSession.startingTime - commonTime
            }
        }
        return effectiveTime
    }
    
    func streamingSessionGraphData() -> [Session] {
        var sessions:[Session] = []
        for (pos, session) in streamingSessions.enumerated() {
            sessions.append(Session(startTime: Double(session.startingTimeGraph), endTime: Double(session.endingTimeGraph), label: "Session \(pos + 1)"))
        }
        return sessions
    }
    
    func formattedEffectiveStreamingTime() -> String {
        let effectiveTime = calculateEffectiveStreamingTime()
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: effectiveTime) ?? "00:00:00"
    }
    
    
}
