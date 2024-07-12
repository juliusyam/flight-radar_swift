//
//  RoundedCorner.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 10/07/2024.
//

import SwiftUI

struct RoundedCornerView: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    RoundedCornerView()
}
