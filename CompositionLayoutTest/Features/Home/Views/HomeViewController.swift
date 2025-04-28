//
//  HomeViewController.swift
//  CompositionLayoutTest
//
//  Created by Abdul Qadar on 28/04/2025.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
   
    private var collectionView: UICollectionView!
    private let viewModel = HomeViewModel()
    private var cancellables = Set<AnyCancellable>()
    private let loaderView = LoaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home"
        setupCollectionView()
        viewModel.fetchData()
        bindViewModel()
    }
    
    private func setupCollectionView() {
        let layout = HomeLayout.createHomeLayout(for: self)
        collectionView = HomeUIComponent.createCollectionView(layout: layout)
        collectionView.dataSource = self
        
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.loaderView.show(on: self?.view)
                } else {
                    self?.loaderView.hide()
                    self?.collectionView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1//viewModel.banners.count
        case 1: return viewModel.categories.count
        case 2: return viewModel.products.count
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
            cell.configure(with: viewModel.banners)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            let model = viewModel.categories[indexPath.item]
            cell.configure(with: model)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            let model = viewModel.products[indexPath.item]
            cell.configure(with: model)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
