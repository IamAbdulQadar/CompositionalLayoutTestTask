//
//  Product.swift
//  CompositionLayoutTest
//
//  Created by Abdul Qadar on 28/04/2025.
//

import Foundation

struct Product {
    let id: UUID = UUID()
    let name: String
    let imageName: String /// this can be url while setting up data from server. But right now i am loading from Assets.
    let price: Double
}
