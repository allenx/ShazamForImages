//
//  PredictionView.swift
//  ShazamForImages
//
//  Created by Allen X on 6/3/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit

class PredictionView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    var labels: [UILabel] = []
    
    //    convenience init(predictions: [InceptionV3.Prediction]) {
    //        self.init()
    //
    //
    //        frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 40, width: UIScreen.main.bounds.size.width, height: 120)
    //        backgroundColor = .white
    //
    //        self.layer.cornerRadius = 8
    //        self.clipsToBounds = true
    //
    //        let label1 = UILabel(frame: CGRect(x: 10, y: 10, width: 0, height: 0))
    //        let label2 = UILabel(frame: CGRect(x: 10, y: 30, width: 0, height: 0))
    //        let label3 = UILabel(frame: CGRect(x: 10, y: 50, width: 0, height: 0))
    //        let label4 = UILabel(frame: CGRect(x: 10, y: 70, width: 0, height: 0))
    //        let label5 = UILabel(frame: CGRect(x: 10, y: 90, width: 0, height: 0))
    //
    //        labels = [label1, label2, label3, label4, label5]
    //
    //        for (index, prediction) in predictions.enumerated() {
    //            labels[index].text = "\(prediction.label) (\(prediction.probability*100)%)"
    //            labels[index].textColor = .black
    //            labels[index].font.withSize()
    //            labels[index].sizeToFit()
    //            addSubview(labels[index])
    //        }
    //
    //        assignGesture()
    //    }
    
    convenience init(foo: Int) {
        self.init()
        
        frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 43, width: UIScreen.main.bounds.size.width, height: 150)
        backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .light)
        let frostedView = UIVisualEffectView(effect: blurEffect)
        frostedView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        frostedView.layer.cornerRadius = 8
        frostedView.clipsToBounds = true
        
        addSubview(frostedView)
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        let label1 = UILabel(frame: CGRect(x: 10, y: 10, width: 0, height: 0))
        label1.font = UIFont.boldSystemFont(ofSize: 20)
        let label2 = UILabel(frame: CGRect(x: 10, y: 40, width: 0, height: 0))
        label2.font = UIFont.systemFont(ofSize: 18)
        let label3 = UILabel(frame: CGRect(x: 10, y: 60, width: 0, height: 0))
        label3.font = UIFont.systemFont(ofSize: 18)
        let label4 = UILabel(frame: CGRect(x: 10, y: 80, width: 0, height: 0))
        label4.font = UIFont.systemFont(ofSize: 18)
        let label5 = UILabel(frame: CGRect(x: 10, y: 100, width: 0, height: 0))
        label5.font = UIFont.systemFont(ofSize: 18)
        
        labels = [label1, label2, label3, label4, label5]
        
        for label in labels {
            label.textColor = .white
            label.sizeToFit()
            addSubview(label)
        }
        
        assignGesture()
    }
    
    func assignGesture() {
        
        self.isUserInteractionEnabled = true
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(goUp))
        swipeUp.direction = .up
        self.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(goDown))
        swipeDown.direction = .down
        self.addGestureRecognizer(swipeDown)
    }
    
    @objc func goUp() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.layer.transform = CATransform3DMakeTranslation(0.0, -95.0, 0.0)
        }, completion: nil)
    }
    
    @objc func goDown() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.layer.transform = CATransform3DIdentity
        }, completion: nil)
    }
    
    func update(newPredictions: [Prediction]) {
        DispatchQueue.main.async {
            for (index, prediction) in newPredictions.enumerated() {
                self.labels[index].text = "\(prediction.label) (\(prediction.probability*100)%)"
                self.labels[index].sizeToFit()
            }
        }
        
    }
    
}

