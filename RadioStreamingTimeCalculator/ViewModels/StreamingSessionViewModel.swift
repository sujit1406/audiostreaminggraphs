//
//  StreamingSessionViewModel.swift
//  RadioStreamingTimeCalculator
//
//  Created by Sujith Antony on 04/09/24.
//

import Foundation

class StreamingSessionViewModel: Identifiable {
    let id: UUID = UUID()
    
    let session: StreamingSession
    
    init(session: StreamingSession) {
        self.session = session
    }
    
    
    var stationName: String {
        self.session.stationName
    }
    
    var startingTime: Date {
        session.startingTime
    }
    
    var startingTimeGraph: Float {
        let components = startingTimeHrs.split(separator: ":")
        return Float(components[0]) ?? 0 + (Float(components[1]) ?? 0 / 60)
    }
    
    var endingTimeGraph: Float {
        let components = endingTimeHrs.split(separator: ":")
        return Float(components[0]) ?? 0 + (Float(components[1]) ?? 0 / 60)
    }
    
    var endingTime: Date {
        session.endingTime
    }
    
    var startingTimeFormatted: String {
        DateFormatter.shortT.string(from: session.startingTime)
    }
    
    var endingTimeFormatted: String {
        DateFormatter.shortT.string(from: session.endingTime)
    }
    
    var startingTimeHrs: String {
        DateFormatter.shortT.string(from: session.startingTime)
    }
    
    var endingTimeHrs: String {
        DateFormatter.shortT.string(from: session.endingTime)
    }
    
    var sessionDuration: TimeInterval {
        session.endingTime - session.startingTime
    }
    
    var sessionDurationHrs: Double {
        (session.endingTime - session.startingTime) / 3600
    }
    
    var sessionDurationFormatted: String {
        let duration = session.endingTime.timeIntervalSince(session.startingTime)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: duration) ?? "00:00:00"
    }
    
}
