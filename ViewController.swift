//
//  ViewController.swift
//  GesturesProject
//
//  Created by Karthikeyan.L on 12/08/24.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var displayLabel: UILabel!
    
    
    let gallery = [#imageLiteral(resourceName: "austin-smart-70350.jpg"), #imageLiteral(resourceName: "clem-onojeghuo-196232.jpg"), #imageLiteral(resourceName: "francesco-gallarotti-2497.jpg"), #imageLiteral(resourceName: "joanna-kosinska-129039.jpg"), #imageLiteral(resourceName: "karsten-wurth-96082.jpg"), #imageLiteral(resourceName: "levi-saunders-71726.jpg"), #imageLiteral(resourceName: "math-83287.jpg"), #imageLiteral(resourceName: "math-83288.jpg"), #imageLiteral(resourceName: "michal-grosicki-235026.jpg"), #imageLiteral(resourceName: "patrick-tomasso-216284.jpg"), #imageLiteral(resourceName: "rodion-kutsaev-82627.jpg"), #imageLiteral(resourceName: "tim-mossholder-244857.jpg")]
    
    var index = 0
    
    // Store the original transform
        var originalTransform: CGAffineTransform = .identity
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        
        imageView1.image = gallery[index]
        // Save the original transform
        originalTransform = imageView1.transform
        displayLabel.isHidden = true
        createGestures()
        
    }
    func createGestures() {
        
        // swiping left Gesture
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(swipeOperation(_:)))
        swipeleft.direction = .left
        swipeleft.numberOfTouchesRequired = 1
        imageView1.addGestureRecognizer(swipeleft)
        imageView1.isUserInteractionEnabled = true
        
        // swiping Right Gesture
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeOperation(_:)))
        swipeRight.direction = .right
        swipeRight.numberOfTouchesRequired = 1
        imageView1.addGestureRecognizer(swipeRight)
        imageView1.isUserInteractionEnabled = true
        
        //Single Tap
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        imageView1.addGestureRecognizer(singleTap)
        imageView1.isUserInteractionEnabled = true
        
        
        // Double Tap
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        imageView1.addGestureRecognizer(doubleTap)
        imageView1.isUserInteractionEnabled = true
        
        // Pinch Gesture
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinching(_:)))
        imageView1.isUserInteractionEnabled = true
        imageView1.addGestureRecognizer(pinchGesture)
        
        // LongPress Gesture
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        longPressGesture.minimumPressDuration = 1.5
        imageView1.addGestureRecognizer(longPressGesture)
        
    }
    @objc func swipeOperation(_ sender: UISwipeGestureRecognizer) {
        
        
        if sender.direction == .left {
            // swipe left:
            if index != gallery.count - 1 {
                index = index + 1
                // back to original Size of the image after zooming
                imageView1.transform = originalTransform
                imageView1.image = gallery[index]
                print("SwipeLeft:\(index)")
            }
        }
        else if sender.direction == .right {
            // swipe right:
            if index != 0 {
                index = index - 1
                imageView1.transform = originalTransform
                imageView1.image = gallery[index]
                print("SwipeRight:\(index)")
            }
            
        }
        
    }
    
    @objc func singleTap (_ sender: UITapGestureRecognizer) {
        displayLabelMessage(withMessage: "Single Time Tapped.", duration: 1.0)
    }
    
    @objc func doubleTap(_ sender: UITapGestureRecognizer) {
        displayLabelMessage(withMessage: "Double Time Tapped.", duration: 1.0)
    }
    
    func displayLabelMessage(withMessage message: String, duration: TimeInterval) {
        
        // To Enable the UIlabel and assign the error message
        displayLabel.isHidden = false
        displayLabel.text = message
        
        // Hide the UIlabel after specified duration
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.displayLabel.isHidden = true
        }
        
    }
    
    @objc func pinching(_ sender: UIPinchGestureRecognizer) {
        
        guard let viewZoom = sender.view else { return }
        
        viewZoom.transform = viewZoom.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
    }
    
    
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
        displayLabelMessage(withMessage: "Long Press Detected.", duration: 1.0)
            
        }
    }
    
    
    
    
}




