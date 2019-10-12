//
//  HistoryTableViewController.swift
//  WaterCounter
//
//  Created by AI on 12.10.2019.
//  Copyright © 2019 iamai. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    private var historyData: [WaterData] = []
    private let fileReader = FileReader()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.loadData()
    }

    func loadData() {
        self.historyData = fileReader.waterData
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return historyData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "historyCell")
        cell.selectionStyle = .none
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        df.timeZone = TimeZone.current
        cell.textLabel?.text = df.string(from: historyData[indexPath.row].dateTime)
        cell.detailTextLabel?.text = String(historyData[indexPath.row].value)
        // Configure the cell...

        return cell
    }
    
}
