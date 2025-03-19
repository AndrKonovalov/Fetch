//
//  LoadingView.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 16.03.2025.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    var lineWidth: CGFloat = 5
    @State var rotation: Double = 0
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        GeometryReader { geometry in
            let dynamicCornerRadius = min(geometry.size.width, geometry.size.height) * 0.15

            RoundedRectangle(cornerRadius: dynamicCornerRadius)
                .stroke(
                    AngularGradient(
                        stops: [
                            .init(color: colorScheme == .light
                                  ? .white
                                  : .black,
                                  location: 0),
                            .init(color: .pink, location: 0.12),
                            .init(color: .purple, location: 0.34),
                            .init(color: colorScheme == .light
                                  ? .white
                                  : .black,
                                  location: 0.42)
                        ],
                        center: .center,
                        angle: .degrees(rotation)
                    ),
                    lineWidth: lineWidth
                )
                .frame(width: geometry.size.width - lineWidth,
                       height: geometry.size.height - lineWidth)
                .padding(.top, lineWidth / 2)
                .padding(.leading, lineWidth / 2)
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

struct LPContainer: View {
    @State var rotation: Double = 0

    var body: some View {
        LoadingView()
    }
}

#Preview {
    LPContainer()
}
