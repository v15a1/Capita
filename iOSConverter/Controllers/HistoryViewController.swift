//
//  HistoryViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-09.
//

import UIKit

class HistoryViewController: RootViewController {

    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var historySegmentedController: UISegmentedControl!
    @IBOutlet weak var deleteAllButton: UIBarButtonItem!

    var savings: [Saving]!
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
        savings = UserDefaults.standard.savings.reversed()

        all.removeAll()
        all.append(contentsOf: loans)
        all.append(contentsOf: savings)
        all = all.sorted(by: { $0.toDate().compare($1.toDate()) == .orderedDescending })
        
        setDeleteAllButton()
        historyTableView.reloadData()
    }

    private func delete(at indexPath: IndexPath) {
        let index = indexPath.row
        loans.remove(at: index)
        UserDefaults.standard.loans = loans
    }
    
    private func animatedReload() {
        UIView.transition(with: historyTableView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.historyTableView.reloadData()
        }, completion: nil)
    }
    
    private func setDeleteAllButton() {
        switch historySegmentedController.selectedSegmentIndex {
        case 0:
            deleteAllButton.isEnabled = !savings.isEmpty
            setEmptyViewIfNeeded(condition: savings.isEmpty, message: "No savings have been stored\n:(")
        case 1:
            setEmptyViewIfNeeded(condition: false, message: "No savings have been stored\n:(")
            return
        case 2:
            deleteAllButton.isEnabled = !loans.isEmpty
            setEmptyViewIfNeeded(condition: loans.isEmpty, message: "No loans have been stored\n:(")
        case 3:
            deleteAllButton.isEnabled = !all.isEmpty
            setEmptyViewIfNeeded(condition: all.isEmpty, message: "No items have been stored\n:(")
        default:
            deleteAllButton.isEnabled = false
        }
    }
    
    private func setEmptyViewIfNeeded(condition: Bool, message: String) {
        historyTableView.restore()
        DispatchQueue.main.async {
            if condition {
                self.historyTableView.setEmptyMessage(message)
            } else {
                self.historyTableView.restore()
            }
        }
        historyTableView.reloadData()
    }

    @IBAction func didChangeSection(_ sender: UISegmentedControl) {
        setDeleteAllButton()
        animatedReload()
    }
    
    @IBAction func didPressDeleteAll(_ sender: Any) {
        let selectedIdx = historySegmentedController.selectedSegmentIndex
        let segmentedTitle = historySegmentedController.titleForSegment(at: selectedIdx)!
        self.showAlert(title: "Delete \(selectedIdx != 3 ? "all \(segmentedTitle)" : "All")?", message: "Are you sure you want to delete all the previous \(selectedIdx != 3 ? "\(segmentedTitle)" : "") calculations?") {
            self.deleteAllBySegment(index: selectedIdx)
        } cancel: {
            return
        }
    }
    
    private func deleteAllBySegment(index: Int) {
        switch index {
        case 0:
            UserDefaults.standard.savings = []
            savings.removeAll()
        case 1:
            return
        case 2:
            UserDefaults.standard.loans = []
            loans.removeAll()
        case 3:
            UserDefaults.standard.loans = []
            UserDefaults.standard.savings = []
            loans.removeAll()
            savings.removeAll()
        default:
            return
        }
        animatedReload()
        showAlert(title: "Success!", message: "The history has been successfully deleted") {
            self.setDeleteAllButton()
        }
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegment == 0 {
            return savings.count
        } else if selectedSegment == 2 {
            return loans.count
        } else if selectedSegment == 3 {
            return all.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTVC.identifier, for: indexPath) as? HistoryTVC {
            if selectedSegment == 0 {
                cell.setup(data: savings[indexPath.row])
            } else if selectedSegment == 2 {
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
