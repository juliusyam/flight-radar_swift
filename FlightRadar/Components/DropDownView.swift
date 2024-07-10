//
//  DropDownView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 10/07/2024.
//

import SwiftUI

struct DropDownView: View {
    let options: [String]
    @State private var isExpanded = false
    @Binding var selected: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(selected)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)
                
                Spacer(minLength: 15)
                
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .resizable()
                    .frame(width: 12, height: 6)
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            if isExpanded {
                ZStack {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .fontWeight(option == selected ? .semibold : .regular)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 16)
                                .foregroundColor(.textPrimary)
                                .onTapGesture {
                                    withAnimation {
                                        selected = option
                                        isExpanded = false
                                    }
                                }
                        }
                    }
                }
            }
        }
        .padding(12)
        .background(.cardPrimary)
        .cornerRadius(corners: [.allCorners])
        .fixedSize(horizontal: true, vertical: false)
        .animation(.easeInOut(duration: 0.3), value: isExpanded)
    }
}


struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        let options = ["Option 1", "Option 2", "Option 3"]
        @State var selectedOption = "Option 1"
        
        DropDownView(options: options, selected: $selectedOption)
    }
}
