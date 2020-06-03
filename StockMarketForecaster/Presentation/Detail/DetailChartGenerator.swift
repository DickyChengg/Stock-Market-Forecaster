//
//  DetailChartGenerator.swift
//  StockMarketForecaster
//
//  Created by Dicky on 02/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import Charts

final class DetailChartGenerator {
    func createLineChartData(actualData: [StockMarketEntity], predictedData: [StockMarketEntity]) -> LineChartData? {
        let chartData = LineChartData()
        
        if !actualData.isEmpty {
            let dataSet = createActualChartDataSet(data: actualData)
            chartData.addDataSet(dataSet)
        }
        
        if !predictedData.isEmpty {
            let dataSet = createPredictedChartDataSet(data: predictedData)
            chartData.addDataSet(dataSet)
        }
        
        if chartData.dataSets.isEmpty {
            return nil
        }
        return chartData
    }
    
    private func createActualChartDataSet(data: [StockMarketEntity]) -> LineChartDataSet {
        let dataEntries = createChartDataEntries(data: data)
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Actual Data")
        dataSet.colors = [UIColor.gray]
        dataSet.circleColors = [UIColor.blue]
        dataSet.circleRadius = 1
        return dataSet
    }
    
    private func createPredictedChartDataSet(data: [StockMarketEntity]) -> LineChartDataSet {
        let dataEntries = createChartDataEntries(data: data)
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Predicted Data")
        dataSet.colors = [UIColor.yellow]
        dataSet.circleColors = [UIColor.red]
        dataSet.circleRadius = 1
        return dataSet
    }
    
    private func createChartDataEntries(data: [StockMarketEntity]) -> [ChartDataEntry] {
        var dataEntries: [ChartDataEntry] = []
        for (index, item) in data.enumerated() {
            let doubleIndex = Double(index)
            let entry = ChartDataEntry(x: doubleIndex, y: item.close)
            dataEntries.append(entry)
        }
        return dataEntries
    }
}
