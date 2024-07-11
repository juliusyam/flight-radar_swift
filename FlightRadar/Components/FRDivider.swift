//
//  FRDivider.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 11/07/2024.
//

import SwiftUI

struct FRDivider: View {
    enum Orientation {
        case vertical
        case horizontal
    }

    var orientation: Orientation =  .horizontal
    var color: Color = .gray
    var dashRate: CGFloat = .infinity
    var thickness: CGFloat = 1


    var body: some View {
        GeometryReader { geometry in
            var dashPattern: [CGFloat] = []
            Path { path in
                let length = orientation == .vertical ? geometry.size.height : geometry.size.width
                if dashRate == .infinity {
                    dashPattern = []
                } else {
                    let dashLength = length / dashRate
                    dashPattern = Array(repeating: dashLength, count: Int(dashRate))
                }
                
                switch orientation {
                case .vertical:
                    path.move(to: CGPoint(x: thickness / 2, y: 0))
                    path.addLine(to: CGPoint(x: thickness / 2, y: length))
                case .horizontal:
                    path.move(to: CGPoint(x: 0, y: thickness / 2))
                    path.addLine(to: CGPoint(x: length, y: thickness / 2))
                }
            }
            .stroke(style: StrokeStyle(lineWidth: thickness, dash: dashPattern))
            .foregroundColor(color)
        }
        .frame(maxWidth: orientation == .vertical ? thickness : .infinity,
               maxHeight: orientation == .horizontal ? thickness : .infinity)
    }

    func color(_ color: Color) -> Self {
        var view = self
        view.color = color
        return view
    }

    func dashRate(_ rate: CGFloat) -> Self {
        var view = self
        view.dashRate = rate
        return view
    }

    func thickness(_ thickness: CGFloat) -> Self {
        var view = self
        view.thickness = thickness
        return view
    }
}

struct FRDivider_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FRDivider()
            FRDivider(orientation: .vertical)
                .color(.blue)
                .dashRate(30)
                .thickness(2)
        }
        .padding()
    }
}
