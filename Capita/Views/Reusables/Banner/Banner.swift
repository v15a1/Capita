//
//  Banner.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-28.
//

import UIKit

enum AlertType {
    case alert, success, error, none
}

class Banner: UIView {

    private var bannerType: AlertType = .none
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: UIFont.ralewaySemiBold, size: 16)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: UIFont.ralewayRegular, size: 14)
        return label
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 12
        return stack
    }()

    var type: AlertType {
        get {
            return bannerType
        }

        set {
            bannerType = newValue
            configBanner()
        }
    }

    var title: String? {
        get {
            return titleLabel.text
        }

        set {
            titleLabel.text = newValue
        }
    }

    var info: String? {
        get {
            return descriptionLabel.text
        }

        set {
            descriptionLabel.text = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        self.addSubview(stack)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
    }

    private func configBanner() {
        switch bannerType {
        case .alert:
            self.backgroundColor = .yellow
        case .success:
            self.backgroundColor = .green
        case .error:
            self.backgroundColor = .red
        case .none:
            return
        }
    }

}
