//
//  ViewController.swift
//  UICollectionDemo
//
//  Created by Pengfei_Luo on 16/2/16.
//  Copyright © 2016年 骆朋飞. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.mainScreen().bounds.size.width
let screenHeight = UIScreen.mainScreen().bounds.size.height

class ViewController: UIViewController {

    var itemData : [String] = []
    
    var menueCollectionView : UICollectionView?
    var pageCollectionView : UICollectionView?
    var bottomView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        itemData = ["A","B", "C", "D","E", "F", "G"]
        setUpUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpUI() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSizeMake(screenWidth / 3, 40)

        menueCollectionView = UICollectionView(frame: CGRectMake(0, 22, screenWidth, 40), collectionViewLayout: layout)
        menueCollectionView?.dataSource = self
        menueCollectionView?.delegate = self
        menueCollectionView?.showsHorizontalScrollIndicator = false
        menueCollectionView?.contentSize = CGSizeMake(screenWidth * 2, 0)
        menueCollectionView?.registerClass(LPFCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        menueCollectionView?.backgroundColor = UIColor.clearColor()
        self.view.addSubview(menueCollectionView!)
        
        bottomView = UIView(frame: CGRectMake(0, menueCollectionView!.bounds.size.height - 5,screenWidth/3.0, 5))
        bottomView?.backgroundColor = UIColor.redColor()
        menueCollectionView?.addSubview(bottomView!)
        
        
        let pageLayout = UICollectionViewFlowLayout()
        pageLayout.minimumLineSpacing = 0
        pageLayout.minimumInteritemSpacing = 0
        pageLayout.itemSize = CGSizeMake(screenWidth,screenHeight - 60)
        pageLayout.scrollDirection = .Horizontal
        
        pageCollectionView = UICollectionView(frame: CGRectMake(0, 60, screenWidth, screenHeight - 60), collectionViewLayout: pageLayout)
        pageCollectionView?.showsHorizontalScrollIndicator = false
        pageCollectionView?.dataSource = self
        pageCollectionView?.contentSize = CGSizeMake(screenWidth * 2, 0)
        pageCollectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        pageCollectionView?.delegate = self
        pageCollectionView?.scrollEnabled = true
        pageCollectionView?.pagingEnabled = true
        self.view.addSubview(pageCollectionView!)
    }
    

}

extension ViewController : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return itemData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == menueCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! LPFCollectionViewCell
            cell.setTitle(itemData[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath)
            let r = arc4random()%255
            let g = arc4random()%255
            let b = arc4random()%255
            cell.contentView.backgroundColor = UIColor(red: CGFloat(r)/CGFloat(255), green: CGFloat(g)/CGFloat(255), blue: CGFloat(b)/CGFloat(255), alpha: 1)
            return cell
        }
    }
}

extension ViewController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == menueCollectionView {
            guard indexPath.row < itemData.count else {
                return
            }
            let cell = menueCollectionView!.cellForItemAtIndexPath(indexPath) as! LPFCollectionViewCell
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.bottomView?.frame = CGRectMake(cell.frame.origin.x, cell.bounds.size.height - 5, cell.bounds.size.width, 5)
                collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
                self.pageCollectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
            })
            
        }
    }
}

extension ViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView == pageCollectionView {
            let index = Int(scrollView.contentOffset.x / (self.pageCollectionView?.frame.size.width)!)
            let indexPath = NSIndexPath(forItem: index, inSection: 0)
            self.collectionView(self.menueCollectionView!, didSelectItemAtIndexPath: indexPath)
            
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {

        if scrollView == self.pageCollectionView {
            if !isZeroSize(CGSizeMake(screenWidth / 3, 40)) {
                self.bottomView?.frame = CGRectMake(scrollView.contentOffset.x/self.pageCollectionView!.frame.size.width * self.view.bounds.size.width/3.0 , self.menueCollectionView!.bounds.size.height - 5,self.view.bounds.size.width/3.0, 5)
            }
        }

    }
    
    func isZeroSize(size : CGSize) -> Bool {
        if CGSizeEqualToSize(CGSizeZero, size) {
            return true
        }
        
        return false
    }
}

