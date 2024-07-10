//
//  FRButton.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 10/07/2024.
//

import SwiftUI

struct FRButton<Content: View>: View {
    let action: () -> Void
    let textView: () -> Content
    var color: Color = .button
    var icon: Image?
    var fillWidth: Bool = false
    var padding: CGFloat = 8
    
    init(action: @escaping () -> Void, @ViewBuilder textView: @escaping () -> Content) {
        self.action = action
        self.textView = textView
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                textView()
                
                Spacer()
                    .frame(maxWidth: fillWidth ? /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ : 0)
                
                if let icon = icon {
                    Spacer()
                        .frame(maxWidth: 10)
                    icon
                }
            }
            .padding(padding)
            .frame(maxWidth: fillWidth ? .infinity : .none)
            .background(color)
            .foregroundColor(.white)
        }
    }
    
    func buttonColor(_ color: Color) -> FRButton {
        var view = self
        view.color = color
        return view
    }
    
    func icon(_ image: Image) -> FRButton {
        var view = self
        view.icon = image
        return view
    }
    
    func fill() -> FRButton {
        var view = self
        view.fillWidth = true
        return view
    }
    
    
    func padding(_ value: CGFloat) -> FRButton {
        var view = self
        view.padding = value
        return view
    }
}

struct FRButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FRButton(action: {
                print("Button tapped")
            }) {
                Text("Click me")
            }
            .buttonColor(.green)
            .padding(16)
            
            FRButton(action: {
                print("Button tapped")
            }) {
                Text("Button with icon")
            }
            .buttonColor(.orange)
            .icon(Image(systemName: "star.fill"))
            .padding(12)
            
            FRButton(action: {
                print("Button tapped")
            }) {
                Text("Fill width")
            }
            .fill()
            .padding(20)
            
            FRButton(action: {
                print("Button tapped")
            }) {
                Text("Wrap content")
            }
            .buttonColor(.purple)
        }
        .padding()
    }
}
