//
//  ViewController.swift
//  UIViewAnimations
//
//  Created by Maksim Vialykh on 06/11/2018.
//  Copyright © 2018 Vialyx. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: - Actions
    @IBAction func buttonDidTap(_ sender: Any) {
        // Check text in field. Animation is starting only if text is empty
        if field.text?.isEmpty ?? true {
            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           // Look options list here https://developer.apple.com/documentation/uikit/uiviewanimationoptions
                           options: [.autoreverse],
                           animations: {
                            // Create CGAffineTransform with 5 degree (CG works with radians) and convert in to radians
                            self.field.transform = CGAffineTransform(rotationAngle: CGFloat(5).degreesToRadians)
                                // Add scale factor to the created transform
                                .scaledBy(x: 1.2, y: 1.2)
            }) { (finish) in
                // Clear transform .identity is a empty transform
                self.field.transform = .identity
                print("\(String(describing: self.field)) animation finish: \(finish)")
            }
        } else {
            // Check animations in label layer
            guard label.layer.animationKeys()?.isEmpty ?? true else {
                // Clear existed animations
                label.layer.removeAllAnimations()
                // Backup center position
                label.center = CGPoint(x: view.center.x, y: label.center.y)
                return
            }
            
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           // .repeat option create loop for that animation
                           options: [.repeat, .autoreverse],
                           animations: {
                            // Concat static text with text from UITextField
                            self.label.text = "Entered name: " + (self.field.text ?? "")
                            // Make offset from UILabel frame
                            self.label.frame = self.label.frame.offsetBy(dx: 100, dy: 0)
            }) { (finish) in
                print("\(String(describing: self.label)) animation finish: \(finish)")
            }
        }
    }
    
}

// TODO: - Move that extension to the separated file FloatingPoint+Converter.swift
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
