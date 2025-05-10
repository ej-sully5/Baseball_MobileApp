//
//  StadiumViewController.swift
//  Project1_EthanSullins
//
//  Created by Ethan Sullins on 12/4/24.
//

import Foundation
import UIKit
import MapKit

class StadiumSearchViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var ASV1: UIScrollView!
    @IBOutlet weak var ASV2: UITextView!
    
    func setLabels() {
        // decorate boxes
        ASV1.layer.cornerRadius = 10
        ASV1.layer.borderWidth = 1
        ASV1.layer.borderColor = UIColor.darkGray.cgColor
        
        ASV2.layer.cornerRadius = 10
        ASV2.layer.borderWidth = 1
        ASV2.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        setupUI()
    }
    
    func setupUI() {
        // Customize the text field and map view if needed
        searchTextField.placeholder = "Enter stadium name"
        searchTextField.borderStyle = .roundedRect
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let searchText = searchTextField.text, !searchText.isEmpty else {
            showAlert(message: "Please enter a stadium name to search.")
            return
        }
        
        searchForStadium(named: searchText)
    }
    
    func searchForStadium(named stadiumName: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = stadiumName
        
        // Optional: Limit the search to the USA
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -95.7129), // Center of USA
            latitudinalMeters: 5000000,
            longitudinalMeters: 5000000
        )
        searchRequest.region = region
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] response, error in
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert(message: "Error searching for stadium: \(error.localizedDescription)")
                return
            }
            
            guard let response = response, let mapItem = response.mapItems.first else {
                self.showAlert(message: "No results found for '\(stadiumName)'.")
                return
            }
            
            self.displayStadiumOnMap(mapItem: mapItem)
        }
    }
    
    func displayStadiumOnMap(mapItem: MKMapItem) {
        // Clear existing annotations
        mapView.removeAnnotations(mapView.annotations)
        
        // Create and add a new annotation for the stadium
        let annotation = MKPointAnnotation()
        annotation.title = mapItem.name
        annotation.coordinate = mapItem.placemark.coordinate
        mapView.addAnnotation(annotation)
        
        // Center the map on the stadium
        let coordinateRegion = MKCoordinateRegion(
            center: mapItem.placemark.coordinate,
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
