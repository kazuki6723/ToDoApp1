//
//  CustomNavigationBar.swift
//  ToDoApp1
//
//  Created by ChibaKazuki on 10/20/21.
//

import UIKit

class CustomNavigationBar: UINavigationBar {
    
    //NavigationBarの高さ
    let barHeight: CGFloat = 66
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: barHeight)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
