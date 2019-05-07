//
//  ViewController.swift
//  project16
//
//  Created by Laurent on 2019-05-06.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(changeMapType))

        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 summer olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the city of light")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it")
        
        mapView.addAnnotations([london, oslo, paris, rome])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        if let pinAnnotationView = annotationView as? MKPinAnnotationView {
                pinAnnotationView.pinTintColor = .blue
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }

        let placeName = capital.title

        if let vc = storyboard?.instantiateViewController(withIdentifier: "webView") as? DetailWebViewController {
            vc.city = placeName
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func changeMapType() {
        let ac = UIAlertController(title: "Map type", message: "Choose a new map type below", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { (UIAlertAction) in
            self.mapView.mapType = .satellite
        }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { (UIAlertAction) in
            self.mapView.mapType = .hybrid
        }))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { (UIAlertAction) in
            self.mapView.mapType = .standard
        }))
        
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem

        present(ac, animated: true)
    }
}
