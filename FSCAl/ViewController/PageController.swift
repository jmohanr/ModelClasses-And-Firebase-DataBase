//
//  PageController.swift
//  FSCAl
//
//  Created by Admin on 08/08/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import ImageSlideshow

class PageController: UIViewController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBOutlet var slideshow: ImageSlideshow!

    override func viewDidLoad() {
        super.viewDidLoad()
     // creating closers
        let storedCloser:(Int,Int)->Int = {$0*$1}
    let counts = storedCloser(2,5)
        print(counts)
        
     
        let localSource = [ImageSource(imageString: "1")!, ImageSource(imageString: "2")!, ImageSource(imageString: "4")!, ImageSource(imageString: "3")!]
        slideshow.slideshowInterval = 2.0
        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        insertSomething(closure: returnHelloWorld)
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
       // slideshow.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.currentPageChanged = { page in
            print("current page:", page)
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        slideshow.setImageInputs(localSource as [InputSource])
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(PageController.didTap))
        slideshow.addGestureRecognizer(recognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didTap() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
//    netedFunctiong i.e function inside the function
    func returnHelloWorld() -> String {
        print("Hello World")
        return "Hello World"
    }
    func insertSomething(closure: () -> String) {
      closure()
    }
    

}

