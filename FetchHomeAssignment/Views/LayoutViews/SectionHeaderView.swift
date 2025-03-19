//
//  SectionHeaderView.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 18.03.2025.
//

import Foundation
import SwiftUI

struct SectionHeaderView: View {

    let cuisine: String

    var body: some View {
        HStack {
            Text(cuisine)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, UIC.padding * 2)
        }
        .frame(height: 40)
        .id(cuisine)
        .background(
            GeometryReader { geo in
                Color.clear
                    .preference(key: SectionHeaderPreferenceKey.self,
                                value: [SectionHeaderData(id: cuisine, minY: geo.frame(in: .named("scroll")).minY)])
            }
        )
    }

}
