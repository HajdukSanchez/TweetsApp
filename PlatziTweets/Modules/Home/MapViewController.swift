//
//  MapViewController.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 4/03/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var mapContainerView: UIView!
    
    // MARK: - Properties
    var posts = [Post]()
    private var map: MKMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Here we have all the views on the screen, so here we have all the space to set bounds to map
        setUpMap()
    }
    
    private func setUpMap() {
        map = MKMapView(frame: mapContainerView.bounds)
        mapContainerView.addSubview(map ?? UIView())
        setUpMarkers()
        navigateToLastPostMarker()
    }
    
    private func setUpMarkers() {
        posts.forEach { item in
            let marker = MKPointAnnotation() // Marker on map
            marker.coordinate = CLLocationCoordinate2D(latitude: item.location.latitude, longitude: item.location.longitude)
            marker.title = item.text
            marker.subtitle = item.author.names
            
            // Add marker to map
            map?.addAnnotation(marker)
        }
    }
    
    private func navigateToLastPostMarker() {
        guard let lastPost = posts.last else { return }
        let lastPostLocation = CLLocationCoordinate2D(latitude: lastPost.location.latitude,
                                                      longitude: lastPost.location.longitude)
        guard let headingMap = CLLocationDirection(exactly: 12) else { return }
        // Set up marker on map
        map?.camera = MKMapCamera(lookingAtCenter: lastPostLocation, fromDistance: 30, pitch: .zero, heading: headingMap)
    }
    
}
