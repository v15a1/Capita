//
//  LandingViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var landingCV: UICollectionView! {
        didSet {
            landingCV.delegate = self
            landingCV.dataSource = self

            landingCV.register(UINib(nibName: LandingCVC.Identifier, bundle: nil), forCellWithReuseIdentifier: LandingCVC.Identifier)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome!"

    }

}

extension LandingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LandingCVC.Identifier, for: indexPath)
        cell.contentView.backgroundColor = .red
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.bounds.width - 60) / 2, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: K.Storyboard.Main, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: K.VC.ViewController)
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
