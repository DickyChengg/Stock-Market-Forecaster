//
//  DetailViewController.swift
//  StockMarketForecaster
//
//  Created by Dicky on 31/05/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import UIKit
import Charts

internal final class DetailViewController: UIViewController {
    private(set) lazy var presenter: DetailPresenter = DetailPresenter(vc: self)
    private lazy var chartGenerator: DetailChartGenerator = DetailChartGenerator()
    
    @IBOutlet weak var chart: LineChartView!
    @IBOutlet weak var loadingView: UIView!
    
    // MARK: Detail Information
    @IBOutlet weak var selectedDateLbl: UILabel!
    @IBOutlet weak var actualCloseLbl: UILabel!
    @IBOutlet weak var predictedCloseLbl: UILabel!
    @IBOutlet weak var accuracyLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLoading()
        chart.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    @IBAction func onTapPredictBtn(_ sender: Any) {
        presenter.predict()
    }
}

// MARK: - Render
extension DetailViewController {
    func render(state: DetailState) {
        title = state.ticker
        
        renderCharts(state: state)
        renderDetailInformation(state: state)
    }
    
    private func renderCharts(state: DetailState) {
        let lineChartData = chartGenerator.createLineChartData(
            actualData: state.actualData,
            predictedData: state.predictedData
        )
        chart.data = lineChartData
    }
    
    private func renderDetailInformation(state: DetailState) {
        selectedDateLbl.text = state.selectedDate
        actualCloseLbl.text = state.actualClose.decimal(3)
        predictedCloseLbl.text = state.predictedClose.decimal(3)
        
        let accuracy = presenter.calculateAccuracy(
            actual: state.actualClose,
            predicted: state.predictedClose
        )
        if accuracy.isNaN {
            accuracyLbl.text = "-"
        } else {
            let accuracyStr = accuracy.decimalLessThanOne(3)
            accuracyLbl.text = "\(accuracyStr)%"
        }
    }
}

// MARK: - Interaction
extension DetailViewController {
    func showLoading() {
        loadingView.alpha = 0.5
    }
    
    func hideLoading() {
        loadingView.alpha = 0
    }
    
    func presentError(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: nil)
        )
        self.present(alert, animated: true, completion: nil)
    }
}

extension DetailViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let index = Int(entry.x)
        presenter.chartValueSelected(index: index)
    }
}
