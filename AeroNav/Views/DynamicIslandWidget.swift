//
//  DynamicIslandWidget.swift
//  AeroNav
//
//  Integracja z Dynamiczną Wyspą (Dynamic Island) oraz Live Activities na iPhone.
//

import SwiftUI
import WidgetKit
import ActivityKit

public struct NavigationAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        public var nextManeuver: String
        public var distanceMeters: Int
        public var speedLimitKmh: Int
        public var speedKmh: Int
        public var etaString: String
        public var hazardAlert: String?

        public init(nextManeuver: String, distanceMeters: Int, speedLimitKmh: Int, speedKmh: Int, etaString: String, hazardAlert: String? = nil) {
            self.nextManeuver = nextManeuver
            self.distanceMeters = distanceMeters
            self.speedLimitKmh = speedLimitKmh
            self.speedKmh = speedKmh
            self.etaString = etaString
            self.hazardAlert = hazardAlert
        }
    }

    public var destinationName: String

    public init(destinationName: String) {
        self.destinationName = destinationName
    }
}

#if canImport(ActivityKit)
public struct DynamicIslandNavigationWidget: Widget {
    public init() {}

    public var body: some WidgetConfiguration {
        ActivityConfiguration(for: NavigationAttributes.self) { context in
            // Widok zablokowanego ekranu (Lock Screen Banner)
            HStack(spacing: 12) {
                Image(systemName: "arrow.turn.up.right.fill")
                    .font(.title2)
                    .foregroundStyle(.green)
                VStack(alignment: .leading, spacing: 2) {
                    Text(context.state.nextManeuver)
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text("Za \(context.state.distanceMeters) m • ETA \(context.state.etaString)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                Spacer()
                // Znak ograniczenia prędkości
                ZStack {
                    Circle()
                        .strokeBorder(.red, lineWidth: 3)
                        .background(Circle().fill(.white))
                        .frame(width: 36, height: 36)
                    Text("\(context.state.speedLimitKmh)")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(.black)
                }
            }
            .padding()
            .background(Color.black.opacity(0.85))
        } dynamicIsland: { context in
            DynamicIsland {
                // Rozwinięta Dynamiczna Wyspa (Expanded)
                DynamicIslandExpandedRegion(.leading) {
                    HStack {
                        Image(systemName: "arrow.turn.up.right.fill")
                            .foregroundStyle(.green)
                            .font(.title3)
                        Text("\(context.state.distanceMeters) m")
                            .font(.system(.subheadline, design: .rounded, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    // Ograniczenie prędkości
                    ZStack {
                        Circle()
                            .strokeBorder(.red, lineWidth: 2)
                            .background(Circle().fill(.white))
                            .frame(width: 30, height: 30)
                        Text("\(context.state.speedLimitKmh)")
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .foregroundStyle(.black)
                    }
                }
                DynamicIslandExpandedRegion(.center) {
                    Text(context.state.nextManeuver)
                        .font(.footnote)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    if let alert = context.state.hazardAlert {
                        Label(alert, systemImage: "exclamationmark.triangle.fill")
                            .font(.caption2)
                            .foregroundStyle(.yellow)
                    }
                }
            } compactLeading: {
                // Zwinięta po lewej (Compact Leading)
                Image(systemName: "arrow.turn.up.right")
                    .foregroundStyle(.green)
            } compactTrailing: {
                // Zwinięta po prawej (Compact Trailing)
                Text("\(context.state.distanceMeters)m")
                    .font(.caption2.bold())
                    .foregroundStyle(.white)
            } minimal: {
                // Minimalistyczna kropka/ikona
                Image(systemName: "arrow.turn.up.right")
                    .foregroundStyle(.green)
            }
        }
    }
}
#endif
