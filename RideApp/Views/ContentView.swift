//
//  ContentView.swift
//  RideApp
//
//  Created by Othmar Gispert on 9/23/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var isShowingSettings = false

    @ObservedObject var manager = DistanceManager()
    @ObservedObject var settings = SettingsManager()

    var body: some View {
        VStack {
            ZStack {
                // Map
                MapView(centerCoordinate: $centerCoordinate,
                        mapAnnotations: locations)
                .ignoresSafeArea()

                // Map position
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 30, height: 30, alignment: .center)
            }

            // Circle button
            Button {
                let location = MKPointAnnotation()
                location.coordinate = centerCoordinate
                locations.append(location)

                if locations.count == 2,
                   let locA = locations.first,
                   let locB = locations.last {
                    let locationA = CLLocation(latitude: locA.coordinate.latitude,
                                               longitude: locA.coordinate.longitude)
                    let locationB = CLLocation(latitude: locB.coordinate.latitude,
                                               longitude: locB.coordinate.longitude)

                    manager.distance(locations: [locationA, locationB])
                } else if locations.count > 2 {
                    manager.distance = 0
                    locations.removeAll()
                }
            } label: {
                let imageNamed = locations.count == 2 ? "trash" : "plus"
                Image(systemName: imageNamed)
            }
            .padding()
            .background(.red)
            .foregroundColor(.white)
            .font(.title)
            .clipShape(Circle())
            .padding(.top, -35)

            // Title
            Text("Distance Evaluation")
                .font(.title)
                .bold()

            ZStack {
                // Ring View
                RingView(percentage: (manager.distance ?? 0) / Double(settings.travelRadius),
                         startColor: .blue,
                         endColor: .pink)
                    .aspectRatio(contentMode: .fit)

                // Result
                if manager.distance != 0 {
                    Text("\(Int(manager.distance ?? 0.0)) km").font(.title)
                }
            }

            // Gear button
            HStack {
                Spacer()
                Button {
                    isShowingSettings.toggle()
                } label: {
                    Image(systemName: "gear")
                }.sheet(isPresented: $isShowingSettings) {
                    SettingsView()
                }
            }.padding(.trailing, 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
    }
}
