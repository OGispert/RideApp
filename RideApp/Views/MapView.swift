//
//  MapView.swift
//  RideApp
//
//  Created by Othmar Gispert on 9/23/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var mapAnnotations: [MKAnnotation]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        //mapView.setCenter(CLLocationCoordinate2DMake(37.334728, -122.008715), animated: true)
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(37.334728, -122.008715),
                                             latitudinalMeters: 1000000,
                                             longitudinalMeters: 1000000), animated: true)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if mapAnnotations.count != uiView.annotations.count {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(mapAnnotations)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var mapViewParent: MapView

        init(_ parent: MapView) {
            self.mapViewParent = parent
        }

        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            mapViewParent.centerCoordinate = mapView.centerCoordinate
        }
    }
}

extension MKPointAnnotation {
    static var applePark: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "Apple Park"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.334903, longitude: -122.008687)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.applePark.coordinate),
                mapAnnotations: [MKPointAnnotation.applePark])
            .previewDevice("iPhone 13 Pro")
    }
}
