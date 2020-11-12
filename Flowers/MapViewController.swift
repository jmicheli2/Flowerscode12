//
//  MapViewController.swift
//  Flowers
//
//  Created by Jacques Micheli on 25/10/2020.
//  Copyright © 2020 byrdland. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.", more: "Londotown")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", more: "Paristown")
        mapView.addAnnotations([london, paris])
        mapView.setCenter(london.coordinate, animated: true)
        print("before set delegate")
        
        // set delegate must be before setRegion. Why ????
        
        mapView.delegate = self
        print("after set delegate")
      
        let region = MKCoordinateRegion( center: london.coordinate, latitudinalMeters: CLLocationDistance(exactly: 500000)!, longitudinalMeters: CLLocationDistance(exactly: 500000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        
        // Excellent :
        
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = "Map"
        navigationItem.backBarButtonItem = backBarBtnItem
    }
    
    /*
     * These two methods are excellent !
     */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("++ viewFor annotation")
        // 1
        guard annotation is Capital else { return nil }

        // 2
        let identifier = "Capital"

        // 3
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView //  Challenge 1

        if annotationView == nil {
            print("annotationVIew is nil")
            //4
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            // 5
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            annotationView?.pinTintColor = UIColor.systemGreen //  Challenge 1
        } else {
            print("annotationVIew is NOT nil")
            // 6
            // annotationView?.pinTintColor = UIColor.systemBlue //  Challenge 1
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        let placeMore = capital.more

        /*
        let ac = UIAlertController(title: placeName, message: placeInfo + "\n\n" + placeMore, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        */
        
        let newViewController = storyboard!.instantiateViewController(withIdentifier: "Detail") as!DetailViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        newViewController.placeName = placeName
        newViewController.placeInfo = placeInfo
        newViewController.placeMore = placeMore
    }

}
