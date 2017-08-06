//
//  ViewController.swift
//  ShazamForImages
//
//  Created by Allen X on 8/6/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit
import CoreML
import CoreMedia

class ViewController: UIViewController {

    var photographer: Photographer!
    
    var videoPreviewView: UIView!
    var predictionView: PredictionView!
    
    let commandGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        videoPreviewView = UIView(frame: view.frame)
        view.addSubview(videoPreviewView)
        predictionView = PredictionView(foo: 1)
        predictionView.layer.transform = CATransform3DMakeTranslation(0.0, 50.0, 0.0)
        view.addSubview(predictionView)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.predictionView.layer.transform = CATransform3DIdentity
        }, completion: nil)
        
        photographer = Photographer()
        photographer.delegate = self
        
        commandGroup.enter()
        photographer.setup(sessionPreset: .medium) {
            succeeded in
            guard succeeded else {
                return
            }
            if let previewLayer = self.photographer.previewLayer {
                self.videoPreviewView.layer.addSublayer(previewLayer)
                self.photographer.previewLayer?.frame = self.videoPreviewView.bounds
            }
            self.commandGroup.leave()
        }
        
        commandGroup.notify(queue: .main) {
            self.photographer.start()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController {
    func recognize(image: CVPixelBuffer) {
        let predictions = Predictor.shared.predict(pixelBuffer: image)
        updateUI(predictions: predictions)
    }
    
    func updateUI(predictions: [Prediction]) {
        predictionView.update(newPredictions: predictions)
    }
}

extension ViewController: PhotographerDelegate {
    func photographer(_ photographer: Photographer, didCapturePhotoBuffer buffer: CVPixelBuffer) {
        recognize(image: buffer)
    }
    
    func photographer(_ photographer: Photographer, didCaptureVideoBuffer buffer: CVPixelBuffer, at: CMTime) {
        recognize(image: buffer)
    }
    
    
}
