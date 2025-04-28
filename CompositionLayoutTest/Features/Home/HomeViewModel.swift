//
//  HomeViewModel.swift
//  CompositionLayoutTest
//
//  Created by Abdul Qadar on 28/04/2025.
//

import Foundation

class HomeViewModel {

    @Published var banners: [Banner] = []
    @Published var categories: [Category] = []
    @Published var products: [Product] = []
    
    @Published var isLoading: Bool = false // ⭐️ Add this

    func fetchData() {
        isLoading = true // Start loader
        Task {
            await loadBanners()
            await loadCategories()
            await loadProducts()
            self.isLoading = false // Stop loader when done
        }
    }

    private func loadBanners() async {
        try? await Task.sleep(for: .seconds(1))
        banners = [
            Banner(imageName: "sliderImg1"),
            Banner(imageName: "sliderImg2"),
            Banner(imageName: "sliderImg3")
        ]
    }

    private func loadCategories() async {
        try? await Task.sleep(for: .seconds(0.5))
        categories = (1...8).map {
            Category(name: "Category \($0)",
            iconName: "categoryImg")
        }
    }

    private func loadProducts() async {
        try? await Task.sleep(for: .seconds(0.5))
        products = (1...20).map {
            Product(
                name: "Product \($0)",
                imageName: "productImg",
                price: Double.random(in: 10...100).rounded(toPlaces: 2)
            )
        }
    }
}
