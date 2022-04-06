//
//  SelectorMenu.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-04-06.
//

import UIKit

protocol ParameterSelectorDelegate: AnyObject {
    func didSelectMenuItem(selectedIndex: Int, item: String)
}

class SelectorMenu: UIView {
    
    lazy var menuItems: [UIAction] = []
    lazy var demoMenu: UIMenu = {
        return UIMenu(title: "Parameter", image: nil, identifier: nil, options: [], children: menuItems)
    }()
    
    var data: [String]!
    var selection: Int? {
        didSet {
            if !menuItems.isEmpty {
                setText(self.data[self.selection ?? 0])
            }
        }
    }
    weak var delegate: ParameterSelectorDelegate?
    
    private let NibName: String = "SelectorMenu"

    @IBOutlet weak var selectorTitle: UILabel!
    @IBOutlet weak var selectionButton: UIButton!
    
    var title: String? {
        get {
            return selectorTitle.text
        }
        
        set {
            selectorTitle.text = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitilizer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInitilizer()
    }
    
    func setMenuData(data: [String]) {
        self.data = data
        for (idx, str) in self.data.enumerated() {
            let action = UIAction(title: str) { invoked in
                self.delegate?.didSelectMenuItem(selectedIndex: idx, item: str)
                self.setText(str)
            }
            menuItems.append(action)
        }
//        selectionButton.setTitle(data.first, for: .normal)
        selectionButton.tintColor = UIColor.CrayonPeach
        selectionButton.menu = demoMenu
        selectionButton.showsMenuAsPrimaryAction = true
    }
    
    private func setText(_ text: String) {
        UIView.animate(withDuration: 0.3) {
            self.selectionButton.setTitle(text, for: .normal)
        }
    }

    private func commonInitilizer() {
        guard let view = self.loadFromNib(NibName) else { return }
        view.frame = self.bounds
        self.addSubview(view)
        

    }
}
