//
//  CollectionCell.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 06.03.2025.
//

import Foundation
import SwiftUI

struct Cell: View {

    var width: CGFloat {
        width(columns: 2)
    }

    var body: some View {
        ZStack {
            Image("TestImage")
                .resizable()
                .scaledToFit()
                .frame(width: width, height: width)
                .cornerRadius(15)
                .shadow(radius: 5)

            LinearGradient(stops: [
                .init(color: .clear, location: 0),
                .init(color: .white.opacity(0.8), location: 0.4),
                .init(color: .white, location: 1)
            ], startPoint: .center, endPoint: .bottom)
            .frame(width: width, height: width)
            .cornerRadius(15)

            VStack {

                Spacer()

                VStack {
                    Text("Christmas Pudding Flapjack")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text("Malaysian")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(2)
            }
            .frame(width: width, height: width)
        }
        .frame(width: width, height: width)
    }

    func width(columns count: Int) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return CGFloat(screenWidth - 4 * UIConstants.padding) / CGFloat(count)
    }
}

#Preview {
    HStack {
        Cell()
        Cell()
    }
}
