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
    
    var data: [(name: String, index: Int)]!
    var selection: Int? {
        didSet {
            if !menuItems.isEmpty {
                let item = data.first { $0.index == selection }!
                setText(item.name)
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
    
    func setMenuData(data: [(name: String, index: Int)]) {
        self.data = data.reversed()
        self.data.forEach { item in
            let action = UIAction(title: item.name) { invoked in
                self.delegate?.didSelectMenuItem(selectedIndex: item.index, item: item.name)
                self.setText(item.name)
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
