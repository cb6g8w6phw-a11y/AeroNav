//
//  AeroNavApp.swift
//  AeroNav
//
//  Główny punkt wejścia natywnej aplikacji iOS.
//

import SwiftUI

@main
struct AeroNavApp: App {
    @StateObject private var settings = SettingsViewModel()
    @StateObject private var navigationEngine = MapKitNavigationEngine()
    @StateObject private var locationManager = DeadReckoningLocationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
                .environmentObject(navigationEngine)
                .environmentObject(locationManager)
                .preferredColorScheme(settings.colorScheme)
        }
    }
}
