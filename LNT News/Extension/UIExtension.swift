//
//  UIExtension.swift
//  NewspaperOnline
//
//  Created by Luong Ngoc Thuyet on 02/07/2021.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import UIKit

class SwipeGesture : UISwipeGestureRecognizer {
    var onSwipeLeft: (() -> Void)? = nil
    var onSwipeRight: (() -> Void)? = nil
    var onSwipeUp: (() -> Void)? = nil
    var onSwipeDown: (() -> Void)? = nil
}

extension UIView {
    func setSwipeLeftGesture(action: @escaping () -> Void) {
        let leftSwipe = SwipeGesture(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        leftSwipe.onSwipeLeft = action
        leftSwipe.direction = .left
        self.addGestureRecognizer(leftSwipe)
    }
    
    func setSwipeRightGesture(action: @escaping () -> Void) {
        let rightSwipe = SwipeGesture(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        rightSwipe.onSwipeRight = action
        rightSwipe.direction = .right
        self.addGestureRecognizer(rightSwipe)
    }
    
    func setSwipeUpGesture(action: @escaping () -> Void) {
        let upSwipe = SwipeGesture(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        upSwipe.onSwipeUp = action
        upSwipe.direction = .up
        self.addGestureRecognizer(upSwipe)
    }
    
    func setSwipeDownGesture(action: @escaping () -> Void) {
        let downSwipe = SwipeGesture(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        downSwipe.onSwipeDown = action
        downSwipe.direction = .down
        self.addGestureRecognizer(downSwipe)
    }
    
    
    
    @objc
    private func respondToSwipeGesture(gesture: SwipeGesture) {
        switch gesture.direction {
        case .left:
            if let onSwipeLeft = gesture.onSwipeLeft { onSwipeLeft() }
        case .right:
            if let onSwipeRight = gesture.onSwipeRight { onSwipeRight() }
        case .up:
            if let onSwipeUp = gesture.onSwipeUp { onSwipeUp() }
        case .down:
            if let onSwipeDown = gesture.onSwipeDown { onSwipeDown() }
        default:
            break
        }
    }
    
}
