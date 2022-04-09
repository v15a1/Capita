//
//  ShowYearsSwitch.swift
//  Capita
//
//  Created by Visal Rajapakse on 2022-04-09.
//

import UIKit

protocol ShowYearsSwitchProtocol: AnyObject {
    func didSwitchButton(_ sender: UISwitch, to value: Bool)
}

class ShowYearsSwitch: UIView {
    
    private let NibName: String = "ShowYearsSwitch"
    
    @IBOutlet weak var showYearsSwitch: UISwitch!
    
    weak var delegate: ShowYearsSwitchProtocol?
    
    var isOn: Bool {
        get {
            return showYearsSwitch.isOn
        }
        
        set {
            showYearsSwitch.setOn(newValue, animated: false)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitializer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInitializer()
    }
    
    private func commonInitializer() {
        guard let view = self.loadFromNib(NibName) else { return }
        view.frame = self.bounds
        self.addSubview(view)
        
        showYearsSwitch.onTintColor = .CrayonPeach.withAlphaComponent(0.5)
        
    }
    
    @IBAction func didSwitch(_ sender: UISwitch) {
        delegate?.didSwitchButton(sender, to: sender.isOn)
    }
    
}
