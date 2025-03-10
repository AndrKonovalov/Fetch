//
//  ControlsBar.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 06.03.2025.
//

import Foundation
import SwiftUI

struct ControlsBar: View {

    var body: some View {
        HStack {
            Text("ControlsBar")
        }
    }
}

#Preview {
    ControlsBar()
}



/*

 presentation ideas
 - Add rating option
 - add sticky "header" with filters
 - add searchbar 


 filters:
  based on raiting
  shuffle
  cusine: (list of cusines to pick from with checkboxes, and clear all option)
  sortBy:
    cusine ( break in sections )
    alphabetical

 */
