//
//  SettingsView.swift
//  RideApp
//
//  Created by Othmar Gispert on 9/23/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var settings = SettingsManager()

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1)))
                    .frame(width: 100, height: 100, alignment: .center)

                Image(systemName: "map")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }.padding(.top, 150)

            Text("Your ride experience")
                .font(.largeTitle)
                .bold()

            Spacer().frame(height: 100)

            Text("How far you'd like to drive?")
                .bold()

            HStack {
                Spacer().frame(width: 26)
                Slider(value: $settings.travelRadius, in: 100...500, step: 100)
                Spacer().frame(width: 26)
            }

            HStack {
                ForEach(0..<Int(settings.travelRadius/100), id: \.self) { _ in
                    Image(systemName: "car")
                        .font(.largeTitle)
                }.padding(.top)
            }

            Text("My radius is \(Int(settings.travelRadius)) km")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top)

            Spacer()

            Button {
                dismiss()
            } label: {
                Text("Done").bold()
            }

        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
