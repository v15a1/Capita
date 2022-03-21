//
//  ImageCardWithButton.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-10.
//

import UIKit

class ImageCardWithButton: UIView {

    lazy var cardImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false // To flag that we are using Constraints to set the layout
        image.image = UIImage(named: "dog")
        image.contentMode = .scaleAspectFill
        return image
    }()

    lazy var gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false // IMPORTANT IF YOU ARE USING CONSTRAINTS INSTEAD OF FRAMES
        return view
    }()

    // VStack equivalent in UIKit
    lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally // Setting the distribution to fill based on the content
        return stack
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 // Setting line number to 0 to allow sentence breaks
        label.text = "Let your curiosity do the booking"
        label.font = UIFont(name: "Raleway-Semibold", size: 20) // Custom font defined for the project
        label.textColor = .white
        return label
    }()

    lazy var cardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("I'm flexible", for: .normal)
        button.setTitleColor(.blue, for: .normal)
//        button.addTarget(self, action: #selector(someObjcMethod), for: .touchUpInside) <- Adding a touch event and function to invoke
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        self.addSubview(cardImage) // Adding the subview to the current view. i.e., self

        // Setting the corner radius of the view
        self.layer.cornerRadius = K.View.CornerRadius
        self.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            cardImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cardImage.topAnchor.constraint(equalTo: self.topAnchor),
            cardImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])

        setupGradientView()
        addTextAndButton()
    }

    private func setupGradientView() {
        let height = self.frame.height * 0.9 // Height of the translucent gradient view

        self.addSubview(gradientView)
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: height)
        ])

        // Adding the gradient
        let colorTop =  UIColor.clear
        let colorBottom = UIColor.black

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(
            x: 0,
            y: self.frame.height - height,
            width: self.frame.width,
            height: height)
        gradientView.layer.insertSublayer(gradientLayer, at:0)
    }

    private func addTextAndButton() {

        // Adding the views to the stackview
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(cardButton)

        gradientView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),

            cardButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        cardButton.layer.cornerRadius = 30 // Half of the height of the button
    }

}
