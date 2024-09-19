//
//  StreamingListView.swift
//  RadioStreamingTimeCalculator
//
//  Created by Sujith Antony on 04/09/24.
//

import Foundation
import SwiftUI

struct StreamingListView: View {
    
    let sessions: [StreamingSessionViewModel]
    
    var body: some View {
        List(self.sessions, id: \.id) { session in
            SessionCellView(session: session)
        }
    }
}

struct SessionCellView: View {
    
    let session: StreamingSessionViewModel
    
    var body: some View {
        
        return HStack {
            
            VStack(alignment: .leading) {
                Text(session.startingTimeFormatted)
                    .font(.custom("Arial",size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                Text(session.endingTimeFormatted)
                    .font(.custom("Arial",size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
                
            }
            
            Spacer()
            
            VStack {
                Text("Duration")
                    .font(.custom("Arial",size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                Text("\(session.sessionDurationFormatted)")
                    .foregroundColor(Color.black)
                    .font(.custom("Arial",size: 22))
            }
            
        }
        
    }
}


struct StockListView_Previews: PreviewProvider {
    static var previews: some View {
        let streamingSession = StreamingSession(url: "www.google.com", stationName: "ClubFM", startingTime: Date.now, endingTime: Date.now + 5*60)
         
          return StreamingListView(sessions: [StreamingSessionViewModel(session: streamingSession)])
    }
}
