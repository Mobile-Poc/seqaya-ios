//
//  DeliveryLocationVC.swift
//  seqayaPoc
//
//  Created by admin101 on 3/26/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit
import MapKit

class DeliveryLocationVC: UIViewController {
    


    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var savedButtonUi: UIButton!
//    @IBOutlet weak var nextButtonUi: UIButton!
    var orderItem : OrderHistory!
    let locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    var newLocationCoordinate:CLLocationCoordinate2D?
    var newLocationName : String?
    var savedLocationArr : [SavedLocationModel] = []
    var getSavedArr:[SavedLocation]?
    var selectedloc :SavedLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        SavedLocationNetwork().get{ (result) in
            self.getSavedArr = result
            self.mapKit.delegate = self
        }
        
       
        
        savedButtonUi.layer.cornerRadius = 5
        savedButtonUi.layer.borderWidth = 1
        savedButtonUi.layer.borderColor = UIColor.white.cgColor
        
        
        
        
        nextButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Helvetica", size: 25.0)], for: UIControlState.normal)
        locationName.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Helvetica", size: 21.0)], for: UIControlState.normal)
        
//        nextButton.customView?.layer.cornerRadius = 5
//        nextButton.customView?.layer.borderWidth = 1
//        nextButton.customView?.layer.borderColor = UIColor.black.cgColor
//        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        locationSearchTable.mapView = mapKit
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true

        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "ابحث عن المكان"
        searchBar.setValue("الغاء", forKey: "_cancelButtonText")
        navigationItem.titleView = searchBar
        
        locationSearchTable.handleMapSearchDelegate = self
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let usermail = UserDefaults.standard.object(forKey: "email") as! String ?? ""
        
            if let locationName = self.newLocationName{
                if let long = self.newLocationCoordinate?.longitude{
                    if let lat = self.newLocationCoordinate?.latitude{
                        orderItem.location = SavedLocation(userid: usermail, address: locationName, long: long, lat: lat)
                        let vc = segue.destination as! DateTimeViewController
                        vc.orderItem = orderItem
                    }
                }
            }
        else {
                let alert = UIAlertController(title: "مشكله في الموقع", message: "الرجاء اختيار مكان التوصيل", preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: "الغاء", style: .cancel, handler: nil)
                alert.addAction(cancel)
            
                present(alert, animated: true, completion: nil)
        }
       
        
    }
    
    @objc func AddNewLocation(){
//        savedLocationArr.append(SavedLocationModel(name: self.newLocationName!, latitude: (self.newLocationCoordinate?.latitude)!, longitude: (self.newLocationCoordinate?.longitude)!))
        let usermail = UserDefaults.standard.object(forKey: "email") as! String ?? ""
        
        let newlocation = SavedLocation(userid: usermail, address: self.newLocationName!, long: (self.newLocationCoordinate?.longitude)!, lat: (self.newLocationCoordinate?.latitude)!)
        SavedLocationNetwork().post(newlocation: newlocation, compilation: { (data) in
//            print(data)
        }, error:{ (error) in
            print(error)
            })
        
        self.viewDidLoad()
    }

//    @IBAction func NextButton(_ sender: UIButton) {
//
    @IBOutlet weak var nextButton: UIBarButtonItem!
    //    }
    @IBOutlet weak var locationName: UIBarButtonItem!
    @IBAction func NextBut(_ sender: UIBarButtonItem) {
    }
    @IBOutlet weak var tollbar: UIToolbar!
    
    @IBAction func SavedLocationButton(_ sender: UIButton) {
//        print(self.getSavedArr)
        
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: "SavedLocation", message: nil, preferredStyle: .actionSheet)
        var alertActionArray : [UIAlertAction] = []
        
        for (index , element)  in (self.getSavedArr?.enumerated())! {
            let firstAction: UIAlertAction = UIAlertAction(title: element.address, style: .default) { action -> Void in
                
                self.mapKit.removeAnnotations(self.mapKit.annotations)
                let annotation = MKPointAnnotation()
                let cooridnate = CLLocationCoordinate2D(latitude: element.lat, longitude: element.long)
                annotation.coordinate = cooridnate
                annotation.title = element.address
             
                self.mapKit.addAnnotation(annotation)
                let span = MKCoordinateSpanMake(0.05, 0.05)
                let region = MKCoordinateRegionMake(cooridnate, span)
                self.mapKit.setRegion(region, animated: true)
            }
            alertActionArray.append(firstAction)
            actionSheetController.addAction(alertActionArray[index])

        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        // add actions
        actionSheetController.addAction(cancelAction)
     
        
        // present an actionSheet...
        present(actionSheetController, animated: true, completion: nil)
    }
}



extension DeliveryLocationVC : MKMapViewDelegate {
    
 
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            let rightButton = UIButton(type: UIButtonType.contactAdd);
            rightButton.addTarget(self, action: #selector(AddNewLocation), for: UIControlEvents.touchUpInside)
            pinView?.canShowCallout = true
            pinView?.rightCalloutAccessoryView = rightButton
            pinView?.isDraggable = true
            //                pinView?.animatesDrop = true
            
        }
        else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        if newState == MKAnnotationViewDragState.ending {
        }
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        
        
        // Remove all annotations
        self.mapKit.removeAnnotations(mapView.annotations)
        
        newLocationCoordinate = mapView.centerCoordinate
        print(mapView.centerCoordinate)
        
        // Add new annotation
        // Get location PlaceMark from mapview coordinate
        let geoCoder = CLGeocoder()
        let kroger = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapView.centerCoordinate
        
        geoCoder.reverseGeocodeLocation(kroger, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            
            // Location name
            if let locationName = placeMark.name {
                annotation.title = locationName
                self.newLocationName = locationName
                self.locationName.title = self.newLocationName
                
                print("locationName: x\(locationName)")
            }
            if let city = placeMark.locality,
                let state = placeMark.administrativeArea {
                annotation.subtitle = "\(city) \(state)"
            }
        })
        
        self.mapKit.addAnnotation(annotation)
//        let span = MKCoordinateSpanMake(0.05, 0.05)
//        let region = MKCoordinateRegionMake(mapView.centerCoordinate, span)
    }
}

extension DeliveryLocationVC : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            print("location:: \(location)")
            let span = MKCoordinateSpanMake(0.03, 0.03)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapKit.setRegion(region, animated: true)
        }
    }
}

extension DeliveryLocationVC : HandleMapSearchProtocol {
    func dropPinZoomIn(placemark: MKPlacemark) {
        
        selectedPin = placemark
        mapKit.removeAnnotations(mapKit.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapKit.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.03, 0.03)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapKit.setRegion(region, animated: true)
    }
    
    
}



