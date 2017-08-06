//
//  Predictor.swift
//  ShazamForImages
//
//  Created by Allen X on 8/6/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit
import CoreML

typealias Prediction = (label: String, probability: Double)

class Predictor: NSObject {
    
    static let shared = Predictor()
    
    fileprivate let inceptionV3 = Inceptionv3()
    
    func predict(pixelBuffer: CVPixelBuffer) -> [Prediction] {
        if let results = try? inceptionV3.prediction(image: pixelBuffer) {
            return parse(results: results)
        }
        return []
    }
    
    func parse(results: Inceptionv3Output) -> [Prediction] {
        let sortedProbs = results.classLabelProbs.sorted(by: {$0.1 > $1.1})
        var parsedPredictions: [Prediction] = []
        
        for (key, value) in sortedProbs[0..<5] {
            parsedPredictions.append((label: key, probability: value))
        }
        return parsedPredictions
    }
}
