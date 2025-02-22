//
//  SearchView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 10/07/2024.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    let searchAction: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("placeholder_search_flight".localized(), text: $searchText)
                .foregroundColor(.textPrimary)
                .onSubmit {
                    searchAction()
                }
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal, 10)
        .frame(height: 44)
        .background(.cardPrimary)
        .cornerRadius()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
            SearchView(searchText: .constant(""), searchAction: {})
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("empty_search_box")
    }
}


