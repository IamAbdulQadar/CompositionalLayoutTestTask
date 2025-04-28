//
//  HomeUIComponent.swift
//  CompositionLayoutTest
//
//  Created by Abdul Qadar on 28/04/2025.
//
import UIKit
import Foundation

class HomeUIComponent {
    static func createCollectionView(layout: UICollectionViewLayout) -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }
}
