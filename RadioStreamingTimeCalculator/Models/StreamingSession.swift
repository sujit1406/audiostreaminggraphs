//
//  StreamingSession.swift
//  RadioStreamingTimeCalculator
//
//  Created by Sujith Antony on 04/09/24.
//

import Foundation

struct StreamingSession: Decodable {
    let url: String
    let stationName: String
    let startingTime: Date
    let endingTime: Date
}

struct StreamingList: Decodable {
    let sessions: [StreamingSession]
}
