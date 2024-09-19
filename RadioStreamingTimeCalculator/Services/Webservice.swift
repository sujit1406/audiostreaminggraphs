//
//  WebService.swift
//  RadioStreamingTimeCalculator
//
//  Created by Sujith Antony on 04/09/24.
//

import Foundation

class Webservice {
    func getSessions(completion: @escaping (([StreamingSession]?) -> Void)) {
        
        if let url = Bundle.main.url(forResource: "StreamingSessions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.standardT)
                let sessionsList = try? decoder.decode(StreamingList.self, from: data)
                sessionsList?.sessions == nil ? completion(nil) : completion(sessionsList?.sessions)
            } catch {
                print("error:\(error)")
            }
            
        }
        
    }
}
