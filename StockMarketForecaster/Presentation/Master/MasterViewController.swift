//
//  MasterViewController.swift
//  StockMarketForecaster
//
//  Created by Dicky on 31/05/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import UIKit

final class MasterViewController: UITableViewController {
    var detailViewController: DetailViewController? = nil
    let tickers = [
        "AAPL", "AMZN", "BABA", "BBCA", "FB", "GOOG", "IBM", "INTC", "MSFT"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            let navigationController = (controllers[controllers.count-1] as! UINavigationController)
            
            guard let detailVC = navigationController.topViewController as? DetailViewController else { return }
            detailViewController = detailVC
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetail" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let ticker = tickers[indexPath.row]
        
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        controller.presenter.set(ticker: ticker)
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
        detailViewController = controller
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = tickers[indexPath.row]
        return cell
    }
}
