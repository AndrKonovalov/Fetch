//
//  ListCell.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 06.03.2025.
//

import Foundation
import SwiftUI

struct ListCell: View {

    var body: some View {
        HStack {
            Image("TestImage")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .cornerRadius(15)
                .shadow(radius: 5)
            VStack(alignment: .leading) {
                Text("Christmas Pudding Flapjack")
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text("Malaysian")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    VStack {
        ListCell()
        ListCell()
        ListCell()
    }

}
