//
//  ViewController.swift
//  TravelBook
//
//  Created by Onur Bilke on 27.02.2025.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    var editMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }

    func setupUI() {
        mapView.delegate = self
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 1
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseLocation(gestureRecognizer:UILongPressGestureRecognizer) {
            
        if gestureRecognizer.state == .began {
            
            let alertController = UIAlertController(title: NSLocalizedString("alert_title", comment: ""), message: NSLocalizedString("alert_message", comment: ""), preferredStyle: .alert)
                    
            alertController.addTextField { textField in
                textField.placeholder = NSLocalizedString("place_name", comment: "")
            }
            
            alertController.addTextField { textField in
                textField.placeholder = NSLocalizedString("description", comment: "")
            }
            
            let saveAction = UIAlertAction(title: NSLocalizedString("save", comment: ""), style: .default) { _ in
                let name = alertController.textFields?[0].text ?? ""
                let description = alertController.textFields?[1].text ?? ""
                
                let touchedPoint = gestureRecognizer.location(in: self.mapView)
                let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
                
                self.chosenLatitude = touchedCoordinates.latitude
                self.chosenLongitude = touchedCoordinates.longitude
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = touchedCoordinates
                annotation.title = name
                annotation.subtitle = description
                self.mapView.addAnnotation(annotation)
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
                
                newPlace.setValue(name, forKey: "title")
                newPlace.setValue(description, forKey: "subtitle")
                newPlace.setValue(self.chosenLatitude, forKey: "latitude")
                newPlace.setValue(self.chosenLongitude, forKey: "longitude")
                newPlace.setValue(UUID(), forKey: "id")
                
                do {
                    try context.save()
                    print("Db Success")
                }
                catch {
                    print("Db Error")
                }
                
                NotificationCenter.default.post(name: NSNotification.Name("newPlace"), object: nil)
                self.navigationController?.popViewController(animated: true)
            }
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil)
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            if #available(iOS 13.0, *) {
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = scene.windows.first,
                   let topController = window.rootViewController {
                    topController.present(alertController, animated: true, completion: nil)
                }
            }
            else {
                if let topController = UIApplication.shared.keyWindow?.rootViewController {
                    topController.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if !editMode {
            
        }
    }
}
