//
//  ControlsBar.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 06.03.2025.
//

import Foundation
import SwiftUI

struct ControlsBarView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var scrollTo: String?
    @Binding var selectedSection: String
    var sections: [String]?

    let animationNameSpace: Namespace.ID

    var body: some View {
        VStack {
            ScrollBarView(scrollTo: $scrollTo,
                          selectedSection: $selectedSection,
                          sections: sections,
                          animationNameSpace: animationNameSpace)
        }
        .padding(.bottom)
        .background(colorScheme == .light ? Color.white : Color.black)
    }
}

struct CBVPContainer: View {

    @Namespace private var animatedNamespace

    @State var scrollTo: String? = "aaa"
    @State var selectedSection: String = "asdfsdf"
    @State var sections: [String] = [
        "asdfsdf",
        "sdfsdfb",
        "csdfsdf",
        "sdfasdfasdf",
        "asdfasdfa",
        "aaadffs"
    ]

    var body: some View {
        ControlsBarView(scrollTo: $scrollTo,
                        selectedSection: $selectedSection,
                        sections: sections,
                        animationNameSpace: animatedNamespace)
    }
}

#Preview {
    CBVPContainer()
}
