//
//  ContentView.swift
//  AeroNav
//
//  Główny interfejs zakładek w stylu iOS: Mapa, Zapisane, Ustawienia.
//

import SwiftUI

public struct ContentView: View {
    @State private var selectedTab: Int = 0
    @EnvironmentObject private var settings: SettingsViewModel
    @EnvironmentObject private var navEngine: MapKitNavigationEngine

    public var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                NativeMapView()
                    .tag(0)
                    .ignoresSafeArea(.all, edges: .top)

                SavedPlacesSwiftView()
                    .tag(1)

                SettingsSwiftView()
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            // Liquid Glass Tab Bar (Dokładnie jak na zdjęciach użytkownika IMG_8427 i IMG_8429)
            HStack(spacing: 48) {
                Button {
                    selectedTab = 0
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "map.fill")
                            .font(.system(size: 22))
                        Text("Mapa")
                            .font(.system(size: 11, weight: .medium))
                    }
                    .foregroundStyle(selectedTab == 0 ? Color.teal : Color.gray.opacity(0.8))
                }

                Button {
                    selectedTab = 1
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "bookmark.fill")
                            .font(.system(size: 22))
                        Text("Zapisane")
                            .font(.system(size: 11, weight: .medium))
                    }
                    .foregroundStyle(selectedTab == 1 ? Color.teal : Color.gray.opacity(0.8))
                }

                Button {
                    selectedTab = 2
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 22))
                        Text("Ustawienia")
                            .font(.system(size: 11, weight: .medium))
                    }
                    .foregroundStyle(selectedTab == 2 ? Color.teal : Color.gray.opacity(0.8))
                }
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 12)
            .background(
                Capsule()
                    .fill(.ultraThinMaterial)
                    .background(
                        Capsule()
                            .fill(Color(red: 0.08, green: 0.17, blue: 0.14).opacity(0.6))
                    )
                    .overlay(Capsule().stroke(Color.white.opacity(0.2), lineWidth: 1))
                    .shadow(color: Color.black.opacity(0.35), radius: 20, y: 10)
            )
            .padding(.bottom, 8)
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct NativeMapView: View {
    @EnvironmentObject private var navEngine: MapKitNavigationEngine
    @EnvironmentObject private var settings: SettingsViewModel

    var body: some View {
        ZStack {
            Color(red: 0.06, green: 0.14, blue: 0.12).ignoresSafeArea()
            VStack {
                Text("MapKit Vector Engine")
                    .font(.headline)
                    .foregroundStyle(.white)
            }
        }
    }
}

struct SavedPlacesSwiftView: View {
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.09, blue: 0.08).ignoresSafeArea()
            Text("Zapisane Miejsca & Mapy Offline")
                .foregroundStyle(.white)
        }
    }
}

struct SettingsSwiftView: View {
    @EnvironmentObject private var settings: SettingsViewModel

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.09, blue: 0.08).ignoresSafeArea()
            Text("Ustawienia (Waze, Alerty, Wygląd)")
                .foregroundStyle(.white)
        }
    }
}
