//
//  DetailPresenter.swift
//  StockMarketForecaster
//
//  Created by Dicky on 01/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import Foundation

internal final class DetailPresenter {
    enum DatePickerSource: String {
        case fromDate = "From Date"
        case toDate = "To Date"
        case selectedDate = "Selected Date"
    }
    
    weak var view: DetailViewController?
    lazy var interactor: StockMarketInteractor = StockMarketInteractor()
    let state: DetailState
    
    private var currentDatePickerSource: DatePickerSource!
    
    init(vc: DetailViewController) {
        view = vc
        state = DetailState()
    }
    
    func viewWillAppear() {
        loadData()
    }
    
    private func render() {
        view?.render(state: state)
    }
    
    private func loadData() {
        view?.showLoading()
        interactor.load(ticker: state.ticker) { [weak self] (response, error) in
            guard let ws = self else { return }
            ws.view?.hideLoading()
            
            if let error = error {
                ws.view?.presentError(message: error.localizedDescription)
            } else {
                ws.state.actualData = response
            }
            ws.render()
        }
        render()
    }
}

// MARK: - General Methods
extension DetailPresenter {
    func set(ticker: String) {
        state.ticker = ticker
    }
    
    func predict() {
        // Convert Entity to MLModelInput
        let inputs: [StockMarketModelInput] = state.actualData.map { item in
            StockMarketModelInput(data: item.json)
        }
        
        // Start Predicting
        do {
            state.predictedData = try interactor.predictions(ticker: state.ticker, data: inputs)
            render()
        } catch {
            view?.presentError(message: error.localizedDescription)
        }
    }
    
    func calculateAccuracy(actual: Double, predicted: Double) -> Double {
        let absError = abs(predicted - actual)
        let diff = absError / actual
        let errorPercentage = diff * 100
        return errorPercentage
    }
    
    func chartValueSelected(index: Int) {
        if let data = state.actualData[safe: index] {
            state.selectedDate = data.dateString
            state.actualClose = data.close
        }
        
        if let data = state.predictedData[safe: index] {
            state.predictedClose = data.close
        }
        render()
    }
}
