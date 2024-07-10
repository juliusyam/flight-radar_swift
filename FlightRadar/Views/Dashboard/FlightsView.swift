//
//  FlightsView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 10/07/2024.
//

import SwiftUI

struct FlightsView: View {
    let options = ["airplane", "airport"]
    @State var selectedOption: String = "airplane"
    @State var searchText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("My Flights")
                .titleStyle(.textPrimary)
                .fillHorizontal(padding: 0, alignment: .center)
                .padding(.bottom, 50)
            
            HStack(alignment: .top) {
                SearchView(searchText: .constant(""), searchAction: {})
                DropDownView(options: options, selected: $selectedOption)
            }
            
            FRButton(action: {
                
            }) {
                Text("Add Flight")
            }
            .icon(Image(systemName: "plus"))
            .padding(12)
            .cornerRadius(corners: [.allCorners])
            
            
        }
        .fillSpacing()
    }
}

struct FlightsView_Previews: PreviewProvider {
    static var previews: some View {
        FlightsView()
    }
}
