//
//  FlightCard.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 11/07/2024.
//

import SwiftUI

//TODO: Correct the fields when they are available on the backend
struct FlightCard: View {
    var flight: Flight
    var onClick: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 20) {
                Image(systemName: "airplane")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 21, height: 21)
                
                Text(flight.airline)
                    .textStyle(weight: .bold)
            }
            
            TravelIndicatorView(
                time: String(flight.distance),
                origin: flight.departureAirport,
                destination: flight.arrivalAirport)
            
            HStack {
                DoubleTextView(text: flight.departureAirport, subText: flight.departureDate)
                
                Spacer()
                
                DoubleTextView(text: flight.departureAirport, subText: flight.departureDate)
                    .startEnd()
            }
        }
        .fillHorizontal(padding: 10)
        .background(.cardPrimary)
        .cornerRadius(corners: [.allCorners])
        .onTapGesture {
            onClick()
        }
    }
}

#Preview {
    FlightCard(flight: Flight(
        id: 1,
        userId: 123,
        departureDate: "2023-07-11",
        flightNumber: "FR123",
        departureAirport: "JFK",
        arrivalAirport: "LAX",
        distance: 2475,
        airline: "FlyRader Airlines",
        createdAt: "2023-07-11T10:00:00Z",
        updatedAt: "2023-07-11T10:00:00Z"
    )) {}
}
