//
//  HistoryViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-09.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var deleteAllButton: UIBarButtonItem!
    @IBOutlet weak var historySegmentedController: UISegmentedControl!

    var loans: [Loan]!
    var selectedSegment: Int {
        return historySegmentedController.selectedSegmentIndex
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        retrieveData()
    }
    
    private func setup() {
        title = "History"

        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.allowsSelection = false
//        historyTableView.separatorStyle = .none
    }

    private func retrieveData() {
        loans = readPersistables(forKey: K.Keys.SavedLoans) ?? []
    }

    @IBAction func didChangeSection(_ sender: UISegmentedControl) {
        historyTableView.reloadData()
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegment == 2 {
            return loans.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedSegment == 2 {
            let cell = UITableViewCell()
            var content = cell.defaultContentConfiguration()
            content.text = "\(loans[indexPath.row].principleAmount)"
            content.secondaryText = "\(loans[indexPath.row].createdAt)"
            cell.contentConfiguration = content
            return cell
        }
        return UITableViewCell()
    }
}
