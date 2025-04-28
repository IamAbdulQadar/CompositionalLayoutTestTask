//
//  BannerCell.swift
//  CompositionLayoutTest
//
//  Created by Abdul Qadar on 28/04/2025.
//

import UIKit

class BannerCell: UICollectionViewCell {
    private let internalCollectionView: UICollectionView
    private let pageControl = UIPageControl()
    
    private var banners: [Banner] = []

    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        internalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)

        internalCollectionView.isPagingEnabled = true
        internalCollectionView.showsHorizontalScrollIndicator = false
        internalCollectionView.dataSource = self
        internalCollectionView.delegate = self
        internalCollectionView.register(BannerImageCell.self, forCellWithReuseIdentifier: "BannerImageCell")

        contentView.addSubview(internalCollectionView)
        contentView.addSubview(pageControl)

        internalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray

        NSLayoutConstraint.activate([
            internalCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            internalCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            internalCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            internalCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 25)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with banners: [Banner]) {
        self.banners = banners
        pageControl.numberOfPages = banners.count
        pageControl.currentPage = 0
        internalCollectionView.reloadData()
    }
}

extension BannerCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerImageCell", for: indexPath) as! BannerImageCell
        let model = banners[indexPath.item]
        cell.configure(with: model)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}


class BannerImageCell: UICollectionViewCell {
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: Banner) {
        // Load your image here
        // For example:
        imageView.image = UIImage(named: model.imageName)
    }
}
