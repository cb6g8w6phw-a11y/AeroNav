//
//  DeadReckoningLocationManager.swift
//  AeroNav
//
//  Zaawansowany mechanizm Dead Reckoning na iOS zapobiegający zamarzaniu
//  pozycji auta w tunelach oraz kanionach miejskich.
//

import Foundation
import CoreLocation
import Combine

public class DeadReckoningLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published public var currentCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 52.148, longitude: 11.518)
    @Published public var speedKmh: Double = 88.0
    @Published public var courseDeg: Double = 72.0
    @Published public var isGpsLost: Bool = false
    @Published public var isDeadReckoningActive: Bool = false
    @Published public var gpsAccuracyMeters: Double = 4.0

    private var deadReckoningTimer: Timer?
    private var lastValidGpsDate: Date = Date()

    public override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.activityType = .automotiveNavigation
        locationManager.distanceFilter = 2.0
        locationManager.requestWhenInUseAuthorization()
    }

    public func startTracking() {
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Sprawdzenie jakości sygnału GPS
        if location.horizontalAccuracy < 0 || location.horizontalAccuracy > 45.0 {
            triggerDeadReckoning()
            return
        }

        // Sygnał GPS prawidłowy
        isGpsLost = false
        isDeadReckoningActive = false
        deadReckoningTimer?.invalidate()
        deadReckoningTimer = nil

        currentCoordinate = location.coordinate
        gpsAccuracyMeters = location.horizontalAccuracy
        if location.speed >= 0 {
            speedKmh = location.speed * 3.6
        }
        if location.course >= 0 {
            courseDeg = location.course
        }
        lastValidGpsDate = Date()
    }

    /// Aktywacja inercyjnej predykcji ruchu (Dead Reckoning) w tunelu
    public func triggerDeadReckoning() {
        guard !isDeadReckoningActive else { return }
        isGpsLost = true
        isDeadReckoningActive = true

        deadReckoningTimer?.invalidate()
        deadReckoningTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.stepDeadReckoning(intervalSeconds: 0.1)
        }
    }

    private func stepDeadReckoning(intervalSeconds: Double) {
        guard speedKmh > 0 else { return }
        let speedMps = (speedKmh * 1000.0) / 3600.0
        let distanceMeters = speedMps * intervalSeconds

        let R = 6371000.0
        let headingRad = (courseDeg * .pi) / 180.0
        let latRad = (currentCoordinate.latitude * .pi) / 180.0
        let lonRad = (currentCoordinate.longitude * .pi) / 180.0

        let newLatRad = asin(
            sin(latRad) * cos(distanceMeters / R) +
            cos(latRad) * sin(distanceMeters / R) * cos(headingRad)
        )

        let newLonRad = lonRad + atan2(
            sin(headingRad) * sin(distanceMeters / R) * cos(latRad),
            cos(distanceMeters / R) - sin(latRad) * sin(newLatRad)
        )

        currentCoordinate = CLLocationCoordinate2D(
            latitude: (newLatRad * 180.0) / .pi,
            longitude: (newLonRad * 180.0) / .pi
        )
    }
}
