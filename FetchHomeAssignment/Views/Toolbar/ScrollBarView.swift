//
//  ScrollBarView.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 16.03.2025.
//

import Foundation
import SwiftUI

struct ScrollBarView: View {
    @Binding var scrollTo: String?
    @Binding var selectedSection: String

    var sections: [String]
    let animationNameSpace: Namespace.ID

    var body: some View {
        ScrollView(.horizontal) {
            ScrollViewReader { proxy in
                HStack(spacing: 20) {
                    ForEach(sections, id: \.self) { section in
                        if selectedSection == section {
                            Text(section)
                                .id(section)
                                .padding(.vertical, 5)
                                .overlay(alignment: .bottom) {
                                    Rectangle()
                                        .frame(height: 2)
                                        .frame(maxWidth: .infinity)
                                        .matchedGeometryEffect(id: "underline",
                                                               in: animationNameSpace)
                                }

                        } else {
                            Text(section)
                                .id(section)
                                .onTapGesture {
                                    withAnimation {
                                        scrollTo = section
                                    }
                                }
                        }
                    }
                }
                .padding(.horizontal)
                .onChange(of: selectedSection) { _, newValue in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .font(.subheadline)
        .fontWeight(.medium)
        .background(Color(.clear))
        .frame(maxWidth: .infinity)
    }

}
