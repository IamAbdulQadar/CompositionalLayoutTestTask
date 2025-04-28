//
//  LoaderView.swift
//  CompositionLayoutTest
//
//  Created by Abdul Qadar on 28/04/2025.
//

import UIKit

class LoaderView: UIView {

    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let backgroundView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        isHidden = true

        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundView.layer.cornerRadius = 10
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)

        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: 100),
            backgroundView.heightAnchor.constraint(equalToConstant: 100),

            activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
    }

    func show(on view: UIView? = {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }()) {
        guard let parentView = view else { return }
        if self.superview == nil {
            parentView.addSubview(self)
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: parentView.topAnchor),
                bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
                leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
                trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
            ])
        }
        isHidden = false
        activityIndicator.startAnimating()
    }

    func hide() {
        isHidden = true
        activityIndicator.stopAnimating()
    }
}
