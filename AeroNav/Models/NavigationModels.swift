//
//  NavigationModels.swift
//  AeroNav
//

import Foundation
import CoreLocation
import MapKit

public struct NavRoute: Identifiable {
    public let id: String
    public let name: String
    public let destination: String
    public let distanceKm: Double
    public let durationMinutes: Int
    public let delayMinutes: Int
    public let trafficWaveSpeedKmh: Int
    public let coordinates: [CLLocationCoordinate2D]
    public let isAiRecommended: Bool
    public let hasBorderCrossing: Bool
    public let borderWaitMinutes: Int?
    public let fuelAdvice: String?
}

public enum IncidentType: String, CaseIterable, Identifiable {
    case police = "Policja & Fotoradary"
    case crash = "Wypadek"
    case hazard = "Zagrożenie na drodze"
    case weather = "Pogoda (Mgła / Gołoledź)"
    case roadworks = "Roboty drogowe"
    case roadClosure = "Zamknięcie drogi"
    case railway = "Przejazd kolejowy"
    case aircraft = "Patrol lotniczy (adsb.lol)"

    public var id: String { rawValue }

    public var iconName: String {
        switch self {
        case .police: return "shield.fill"
        case .crash: return "exclamationmark.octagon.fill"
        case .hazard: return "triangle.fill"
        case .weather: return "cloud.fog.fill"
        case .roadworks: return "hammer.fill"
        case .roadClosure: return "nosign"
        case .railway: return "tram.fill"
        case .aircraft: return "airplane"
        }
    }
}

public struct RoadIncident: Identifiable {
    public let id: String
    public let type: IncidentType
    public let title: String
    public let details: String
    public let coordinate: CLLocationCoordinate2D
    public let speedLimitKmh: Int?
    public let timestamp: Date
    public let verifiedReportsCount: Int
    public let source: String
}

public struct FuelStationInfo: Identifiable {
    public let id: String
    public let brand: String
    public let name: String
    public let priceEur: Double
    public let pricePln: Double
    public let coordinate: CLLocationCoordinate2D
    public let distanceKm: Double
    public let country: String
}

public struct BorderCrossingInfo: Identifiable {
    public let id: String
    public let name: String
    public let routeName: String
    public let currentWaitMinutes: Int
    public let isRecommendedAlternative: Bool
    public let detourDistanceKm: Double
    public let timeSavedMinutes: Int
}
