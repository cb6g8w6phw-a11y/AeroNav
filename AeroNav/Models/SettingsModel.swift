//
//  SettingsModel.swift
//  AeroNav
//
//  Zarządzanie konfiguracją ostrzeżeń Waze/ADAC, stylu Liquid Glass i asystenta AI.
//

import SwiftUI
import Combine

public enum GlassStyle: String, CaseIterable {
    case translucent = "Przezroczysty"
    case matte = "Matowy"
    case off = "Wyłączony"
}

public class SettingsViewModel: ObservableObject {
    // Liquid Glass & Appearance
    @AppStorage("useLiquidGlass") public var useLiquidGlass: Bool = true
    @AppStorage("glassStyle") public var glassStyle: GlassStyle = .translucent
    @AppStorage("nightModeSelection") public var nightModeSelection: String = "auto"
    @AppStorage("autoDimming") public var autoDimming: Bool = true
    @AppStorage("accentTheme") public var accentTheme: String = "teal"

    // Waze & Road Alerts (IMG_8429, IMG_8430, IMG_8431)
    @AppStorage("useWazeReports") public var useWazeReports: Bool = true
    @AppStorage("warnPoliceSpeedTraps") public var warnPoliceSpeedTraps: Bool = true
    @AppStorage("warnCrashes") public var warnCrashes: Bool = true
    @AppStorage("warnHazards") public var warnHazards: Bool = true
    @AppStorage("warnWeather") public var warnWeather: Bool = true
    @AppStorage("warnRoadworks") public var warnRoadworks: Bool = true
    @AppStorage("warnRoadClosures") public var warnRoadClosures: Bool = true
    @AppStorage("warnTrafficJams") public var warnTrafficJams: Bool = true

    // Alerts options
    @AppStorage("showReportsOnMap") public var showReportsOnMap: Bool = true
    @AppStorage("chimeAndSayWhileNavigating") public var chimeAndSayWhileNavigating: Bool = true
    @AppStorage("ignoreReportsOlderThanHours") public var ignoreReportsOlderThanHours: Int = 2

    // Police Specifics
    @AppStorage("policeHeatMap") public var policeHeatMap: Bool = true
    @AppStorage("policeRiskScoreWhileDriving") public var policeRiskScoreWhileDriving: Bool = true
    @Published public var policeReportsRemembered: Int = 6

    // Aircraft & ADS-B
    @AppStorage("policePlanesAndHelicopters") public var policePlanesAndHelicopters: Bool = true

    // Navigation Intelligence & Features
    @AppStorage("aiPredictiveAssistant") public var aiPredictiveAssistant: Bool = true
    @AppStorage("trafficWaveVisualization") public var trafficWaveVisualization: Bool = true
    @AppStorage("trueTransitTimeFilter") public var trueTransitTimeFilter: Bool = true
    @AppStorage("deadReckoningTunnelGPS") public var deadReckoningTunnelGPS: Bool = true
    @AppStorage("silentRerouting") public var silentRerouting: Bool = true
    @AppStorage("greenWaveGlosa") public var greenWaveGlosa: Bool = true
    @AppStorage("warnRailwayCrossings") public var warnRailwayCrossings: Bool = true

    // Fuel & Border
    @AppStorage("borderWaitTimes") public var borderWaitTimes: Bool = true
    @AppStorage("borderFuelArbitrage") public var borderFuelArbitrage: Bool = true
    @AppStorage("destinationParkingPredictor") public var destinationParkingPredictor: Bool = true
    @AppStorage("germanUmweltzoneStickers") public var germanUmweltzoneStickers: Bool = true

    // Haptics & Voice
    @AppStorage("hapticsEnabled") public var hapticsEnabled: Bool = true
    @AppStorage("hapticIntensity") public var hapticIntensity: String = "medium"
    @AppStorage("voiceControlEnabled") public var voiceControlEnabled: Bool = true

    public var colorScheme: ColorScheme? {
        switch nightModeSelection {
        case "night": return .dark
        case "day": return .light
        default: return nil // System auto
        }
    }

    public func forgetAllPoliceReports() {
        policeReportsRemembered = 0
    }
}
