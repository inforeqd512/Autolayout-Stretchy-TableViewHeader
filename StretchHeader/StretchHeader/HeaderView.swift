//
//  HeaderView.swift
//  StretchHeader
//
//  Created by Info Reqd on 25/3/17.
//  Copyright © 2017 Info Reqd. All rights reserved.
//

import UIKit

/// View is setup in IB as follows
///         imageView.contentMode = .scaleAspectFill -> so that as the height of the imageview increases, the image stretches per aspect
///         imageView.clipsToBounds = true -> the image is displayed only in the bounds of the redView and not beyond it
///         imageview's bottom == redview's bottom and not the other way round as the content offset along with it's sign is used to change it's constant

class HeaderView: UIView {
    
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var redViewEqualHeightSuperView: NSLayoutConstraint!
    @IBOutlet weak var imageBottomEqualRedViewBottom: NSLayoutConstraint!
    @IBOutlet weak var imageHeightEqualRedViewHeight: NSLayoutConstraint!
    
    func containerViewDidScroll(ToOffset offset: CGPoint, withInset inset: UIEdgeInsets) {
        redViewEqualHeightSuperView.constant = inset.top
        
        //when tableView scrolls DOWN, offset is -ve
        //when tableView scrolls UP, offset is +ve
        let offsetForScrollView = offset.y + inset.top

        //this reverses the offset so it shows the height increase direction
        let offsetY = -(offsetForScrollView)
        
        if offsetY > 0 {
            //if the height is increasing then the redView should STOP clipping all its subviews to its bounds so the imageview EXPANDS with it due to its Aspect Fill property
            //even though clipsToBounds==false is the default value this assignment is also needed to complete the toggle from the state change below
            redView.clipsToBounds = false
        }else{
            //if the height is decreasing then the redView should START clipping all its subviews to its bounds so the imageview stays within the redview
            redView.clipsToBounds = true
        }
        
        if offsetY >= 0 {
            //if the height is increasing, then keep the imageView bottom locked to Red View Bottom
            imageBottomEqualRedViewBottom.constant = 0
        }else{
            //if the height is decreasing, then lock the imageView to the redView's bottom with a positive offset so that the image seems to sun set but also move up since only half the offset is used
            imageBottomEqualRedViewBottom.constant = -offsetY / 2
        }
        
        //if the height is increasing,, then INCREASE the imageView's height by the offset
        //if the height is decreasing, then DECREASE the imageView's height but honor the inset
        imageHeightEqualRedViewHeight.constant = max(offsetY + inset.top, inset.top)

    }
}
