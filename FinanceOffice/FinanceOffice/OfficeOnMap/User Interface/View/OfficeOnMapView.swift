//
//  OfficeOnMapView.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class OfficeOnMapViewController: UIViewController, OfficeOnMapViewProtocol {
    
    var presenter: OfficeOnMapPresenterProtocol?
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Map"
        self.presenter?.getOfficeLocationData()
    }
    
    // MARK: Private Methods
    func showAlertView(msg: String, title: String) {
        
        DispatchQueue.main.async() {
            let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action:UIAlertAction) in
        }))
        
//        present(alertController, animated: true, completion: nil)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    // MARK: OfficeOnMapViewProtocol Methods
    func updateOfficeLocationDataOnView(data: OfficeOnMapItemDM) {
        
        if let latitudeValue = data.latitudeOfOffice, let longitudeValue = data.longitudeOfOffice {
            let annotation = MKPointAnnotation()
            annotation.title = data.nameOfOffice
            
            var valueOfAddress: String = ""
            if let zipCode = data.zipCodeOfOffice {
                valueOfAddress.append("\(zipCode) ")
            }
            if let city = data.cityOfOffice {
                valueOfAddress.append("\(city), ")
            }
            if let address = data.addressOfOffice {
                valueOfAddress.append(address)
            }
            annotation.subtitle = valueOfAddress
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitudeValue, longitude: longitudeValue)
            mapView.addAnnotation(annotation)
            mapView.isZoomEnabled = true
            mapView.setCamera(MKMapCamera(lookingAtCenter: annotation.coordinate, fromEyeCoordinate: annotation.coordinate, eyeAltitude: 1000), animated: true)
            
        }
    }
    
    func showEmptyDataState() {
        self.showAlertView(msg: "Location in not define.", title: "")
    }
    
    
}



