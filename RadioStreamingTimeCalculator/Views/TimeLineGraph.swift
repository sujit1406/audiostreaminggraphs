//
//  BarChartView.swift
//  RadioStreamingTimeCalculator
//
//  Created by Sujith Antony on 04/09/24.
//

import SwiftUI
import Charts

struct Session: Identifiable {
    let id = UUID()
    let startTime: Double
    let endTime: Double
    let label: String 
}


struct TimelineGraph: View {
    let sessions: [Session]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack {
                GeometryReader { geometry in
                    ZStack {
                        Path { path in
                            let graphHeight = geometry.size.height
                            path.move(to: CGPoint(x: 0, y: graphHeight-20))
                            path.addLine(to: CGPoint(x: geometry.size.width, y: graphHeight-20)) // X-axis
                        }
                        .stroke(Color.black, lineWidth: 2)
                        
                        ForEach(0..<9) { index in
                            let xPosition = geometry.size.width / 8 * CGFloat(index)
                            Text("\(index * 3):00")
                                .position(x: xPosition, y: geometry.size.height - 10)
                        }
                        
                        ForEach(0..<9) { index in
                            let xPosition = geometry.size.width / 8 * CGFloat(index)
                            Rectangle()
                                .frame(width: 1, height: 10)
                                .position(x: xPosition, y: geometry.size.height - 25)
                        }
                        
                        ForEach(0..<sessions.count, id: \.self) { index in
                            let session = sessions[index]
                            
                            let graphWidth = geometry.size.width
                            
                            let xScale = graphWidth / 24
                            let sessionStartX = session.startTime * xScale
                            let sessionWidth = (session.endTime - session.startTime) * xScale

                            let laneHeight = (geometry.size.height - 20) / CGFloat(sessions.count)
                            let yPosition = CGFloat(index) * laneHeight
                            
                            Rectangle()
                                .fill(Color.blue.opacity(0.5))
                                .frame(width: sessionWidth, height: laneHeight - 10)
                                .position(x: sessionStartX + sessionWidth / 2, y: yPosition + laneHeight / 2)
                            
                            Text(session.label)
                                .foregroundColor(.white)
                                .position(x: sessionStartX + sessionWidth / 2, y: yPosition + laneHeight / 2)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .frame(width: 1000, height: 300)
            }
        }
        .frame(height: 300)
        .border(Color.gray, width: 1)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}


#Preview {
    
    let sessions: [Session] = [
        Session(startTime: 1, endTime: 4, label: "Session 1"),
        Session(startTime: 3, endTime: 6, label: "Session 2"),
        Session(startTime: 5, endTime: 8, label: "Session 3"),
        Session(startTime: 7, endTime: 10, label: "Session 4"),
        Session(startTime: 9, endTime: 13, label: "Session 5"),
        Session(startTime: 12, endTime: 15, label: "Session 6"),
        Session(startTime: 14, endTime: 18, label: "Session 7"),
        Session(startTime: 17, endTime: 20, label: "Session 8")
    ]
    return TimelineGraph(sessions: sessions)
}
