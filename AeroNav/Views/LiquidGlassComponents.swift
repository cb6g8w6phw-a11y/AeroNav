//
//  LiquidGlassComponents.swift
//  AeroNav
//
//  Komponenty stylu Liquid Glass i kapsułek dla SwiftUI.
//

import SwiftUI

public struct LiquidGlassCapsuleModifier: ViewModifier {
    var isMatte: Bool = false

    public func body(content: Content) -> some View {
        content
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Group {
                    if isMatte {
                        Capsule()
                            .fill(Color(red: 0.08, green: 0.14, blue: 0.12).opacity(0.92))
                            .overlay(Capsule().stroke(Color.white.opacity(0.15), lineWidth: 1))
                    } else {
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .background(
                                Capsule()
                                    .fill(Color(red: 0.09, green: 0.22, blue: 0.18).opacity(0.4))
                            )
                            .overlay(
                                Capsule()
                                    .stroke(
                                        LinearGradient(
                                            colors: [
                                                Color.white.opacity(0.4),
                                                Color.white.opacity(0.1),
                                                Color.teal.opacity(0.2)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            )
                            .shadow(color: Color.black.opacity(0.25), radius: 12, x: 0, y: 6)
                    }
                }
            )
    }
}

public struct LiquidGlassCardModifier: ViewModifier {
    var isMatte: Bool = false

    public func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(isMatte ? Color(red: 0.07, green: 0.12, blue: 0.10).opacity(0.95) : Color(red: 0.08, green: 0.17, blue: 0.14).opacity(0.65))
                    .overlay(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .stroke(Color.white.opacity(isMatte ? 0.1 : 0.22), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.3), radius: 16, x: 0, y: 8)
            )
    }
}

extension View {
    public func liquidGlassCapsule(isMatte: Bool = false) -> some View {
        self.modifier(LiquidGlassCapsuleModifier(isMatte: isMatte))
    }

    public func liquidGlassCard(isMatte: Bool = false) -> some View {
        self.modifier(LiquidGlassCardModifier(isMatte: isMatte))
    }
}
