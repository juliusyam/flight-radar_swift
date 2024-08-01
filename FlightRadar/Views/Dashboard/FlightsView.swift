//
//  FlightsView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 10/07/2024.
//

import SwiftUI

struct FlightsView: View {
    @EnvironmentObject var apiService: ApiService
    @State private var selectedOption: FlightOption = .all
    @State var searchText: String = ""
    @State var isLoading: Bool = false
    @State var error: String = ""
    @State var flights: [Flight] = []
    
    private func createFlightQueryParams() -> FlightQueryParams {
        switch selectedOption {
        case .all:
            return FlightQueryParams(airline: nil, airport: nil)
        case .airplane:
            return FlightQueryParams(airline: selectedOption.rawValue, airport: nil)
        case .airport:
            return FlightQueryParams(airline: nil, airport: selectedOption.rawValue)
        }
    }
    
    @MainActor
    private func fetchFlights() {
        Task {
            defer {
                isLoading = false
            }
            
            do {
                error = ""
                isLoading = true
                flights = try await apiService.getFlights(params: createFlightQueryParams())
            } catch let error as APIError {
                self.error = error.errorMessage
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
    
    var body: some View {
        ScrollVStack {
            Text("label_my_flights")
                .titleStyle(.textPrimary)
                .fillHorizontal(padding: 0, alignment: .center)
                .padding(.bottom, 50)
            
            HStack(alignment: .top) {
                SearchView(searchText: .constant(""), searchAction: {})
                DropDownView(selected: $selectedOption)
            }
            .onChange(of: selectedOption) { _ in
                fetchFlights()
            }
            
            FRButton("button_add_flight".localized(), icon: Image(systemName: "plus")) {

            }
            .cornerRadius()
            
            if !flights.isEmpty {
                LazyVStack(spacing: 10) {
                    ForEach(flights, id: \.id) { flight in
                        FlightCard(flight: flight) {
                            //TODO: Flight card action
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .onAppear() {
          fetchFlights()
        }
        
        if isLoading {
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
            .fillSpacing(alignment: .center)
        }
        
        if !error.isEmpty {
            VStack {
                ErrorView(error: error)
            }
        }
    }
}

struct FlightsView_Previews: PreviewProvider {
    static var previews: some View {
        FlightsView()
            .environmentObject(ApiService(nil))
    }
}
