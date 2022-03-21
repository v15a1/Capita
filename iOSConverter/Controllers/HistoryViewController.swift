//
//  HistoryViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-09.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var historySegmentedController: UISegmentedControl!
    @IBOutlet weak var deleteAllButton: UIBarButtonItem!

    var savings: [Loan]!
    var mortgage: [Loan]!
    var loans: [Loan]!
    var all: [Persistable] = []

    var selectedSegment: Int {
        return historySegmentedController.selectedSegmentIndex
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        retrieveData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieveData()
    }
    
    private func setup() {
        title = "History"

        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.allowsSelection = false
        historyTableView.separatorStyle = .none
        historyTableView.register(UINib(nibName: HistoryTVC.identifier, bundle: nil), forCellReuseIdentifier: HistoryTVC.identifier)
    }

    private func retrieveData() {
        loans = UserDefaults.standard.loans.reversed()

        all.removeAll()
        all.append(contentsOf: loans)

        historyTableView.reloadData()
    }

    private func delete(at indexPath: IndexPath) {
        let index = indexPath.row
        loans.remove(at: index)
        UserDefaults.standard.loans = loans
    }

    private func sortAll() -> [Persistable] {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "IST")
        dateFormatter.dateFormat = "dd MMM yyyy"

        return all
            .map { return ($0, dateFormatter.date(from: $0.createdAt)!) }
            .sorted { $0.1 > $1.1 }
            .map(\.0)
    }

    @IBAction func didChangeSection(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 2:
            deleteAllButton.isEnabled = !loans.isEmpty
        case 3:
            deleteAllButton.isEnabled = !all.isEmpty
        default:
            deleteAllButton.isEnabled = false
        }
        historyTableView.reloadData()
    }
    @IBAction func didPressDeleteAll(_ sender: Any) {
        self.showAlert(title: "Delete All?", message: "Are you sure you want to delete all the previous calculations?") {
            //Delete
        } cancel: {
            return
        }

    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegment == 2 {
            return loans.count
        } else if selectedSegment == 3 {
            return all.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTVC.identifier, for: indexPath) as? HistoryTVC {
            if selectedSegment == 2 {
                cell.setup(data: loans[indexPath.row])
            } else if selectedSegment == 3 {
                cell.setup(data: all[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle  == .delete {
            delete(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
