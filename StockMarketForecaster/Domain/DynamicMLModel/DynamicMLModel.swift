//
//  DynamicMLModel.swift
//  StockMarketForecaster
//
//  Created by Dicky on 01/06/20.
//  Copyright © 2020 Organization Name. All rights reserved.
//

import CoreML

internal final class DynamicMLModel<Input: DynamicMLModelInput, Output: DynamicMLModelOutput> {
    private let model: MLModel
    
    init(model: String) throws {
        let bundle = Bundle(for: DynamicMLModel.self)
        guard let modelURL = bundle.url(forResource: model, withExtension: "mlmodelc") else {
            throw DynamicMLModelError.errorMessages(["MLModel with name: \(model) not found!"])
        }
        
        do {
            self.model = try MLModel(contentsOf: modelURL)
        } catch {
            throw DynamicMLModelError.errorMessages(["Failed to dynamically load \(model): \(error.localizedDescription)"])
        }
    }
    
    func prediction(
        input: Input,
        options: MLPredictionOptions = MLPredictionOptions()
    ) throws -> Output {
        try validateInput(inputs: [input])
        
        let outFeatures = try model.prediction(from: input, options: options)
        return Output.init(features: outFeatures)
    }
    
    func predictions(
        inputs: [Input],
        options: MLPredictionOptions = MLPredictionOptions()
    ) throws -> [Output] {
        try validateInput(inputs: inputs)
        
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        
        var results: [Output] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  Output.init(features: outProvider)
            results.append(result)
        }
        return results
    }
    
    private func validateInput(inputs: [Input]) throws {
        var errorMessages: [String] = []
        for input in inputs {
            do {
                try input.validateInput()
            } catch {
                errorMessages.append(error.localizedDescription)
            }
        }
        
        if !errorMessages.isEmpty {
            throw DynamicMLModelError.errorMessages(errorMessages)
        }
    }
}
