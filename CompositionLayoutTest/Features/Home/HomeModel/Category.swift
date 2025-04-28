//
//  Category.swift
//  CompositionLayoutTest
//
//  Created by Abdul Qadar on 28/04/2025.
//

import Foundation

struct Category {
    let id: UUID = UUID()
    let name: String
    let iconName: String /// this can be url while setting up data from server. But right now i am loading from Assets.
}
