//
//  SecViewController.swift
//  MyApp
//
//  Created by Admin on 09/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class WalkThroughViewController: UIViewController,UIPageViewControllerDataSource {
    
    @IBOutlet weak var pageIndicator: UIPageControl!
    @IBOutlet weak var bottomView: UIView!
    var pageController: UIPageViewController!
    var pageTitle : NSArray = NSArray()
    var pagePhoto : NSArray = NSArray()
    var viewControllers :NSArray = NSArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitle = ["This is The App Guruz", "This is Table Tennis 3D", "This is Hide Secrets","Sweettutos.com is your blog of choice for Mobile tutorials","I write mobile tutorials mainly targeting iOS","And sometimes I write games tutorials about Unity","Keep visiting sweettutos.com for new coming tutorials, and don't forget to subscribe to be notified by email :)"]
        pagePhoto = ["1","3","5","2","7","4","6"]
        // Page indicator Settup
        pageIndicator.pageIndicatorTintColor = UIColor.red
        pageIndicator.currentPageIndicatorTintColor = UIColor.black
        pageIndicator.numberOfPages = pagePhoto.count
       
           //  Page Controller SetUp
        pageController = self.storyboard?.instantiateViewController(withIdentifier: "pageVC") as! UIPageViewController
        pageController.dataSource = self
        let pageCotentView:ThirdViewController = getViewControllerAtIndex(index: 0)
        viewControllers = [pageCotentView]
        self.pageController .setViewControllers(viewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        pageController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self .addChildViewController(pageController)
        self.view .addSubview(pageController.view)
        self.view .bringSubview(toFront: bottomView)
        self.view .bringSubview(toFront: pageIndicator)
        pageController .didMove(toParentViewController: nil)
     
        
    }
    
    //MARK:- Displaying Data in Ui Controllers
    
    func getViewControllerAtIndex(index: NSInteger) -> ThirdViewController {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        pageContentViewController.lblTitle = "\(pageTitle[index])"
        pageContentViewController.imgName = "\(pagePhoto[index])"
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }

//MARK:-UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent: ThirdViewController = viewController as! ThirdViewController
        var index = pageContent.pageIndex
        
        pageIndicator.currentPage = index

        if ((index == 0) || (index == NSNotFound)) {
            return nil
        }
        
        index -= 1

        return getViewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: ThirdViewController = viewController as! ThirdViewController
        var index = pageContent.pageIndex
       pageIndicator.currentPage = index

        if (index == NSNotFound) {
            return nil;
        }
        
        index += 1
        if (index == pageTitle.count) {
           
            return nil;
        }
       
        return getViewControllerAtIndex(index: index)
    }
    
     func presentationCount(for pageViewController: UIPageViewController) -> Int // The number of items reflected in the page indicator.
    {
        return pageTitle.count
    }
 
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    @IBAction func startAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "walkthroughPresented")
        UserDefaults.standard.synchronize()
    }
}
