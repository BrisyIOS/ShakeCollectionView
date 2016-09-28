//
//  ViewController.swift
//  ShakeCollectionView
//
//  Created by zhangxu on 16/9/27.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.mainScreen().bounds.size.width;
let kScreenHeight = UIScreen.mainScreen().bounds.size.height;
let colown = 3;
let cellWH = CGFloat(90);
let marginW = (kScreenWidth - CGFloat(colown) * cellWH) / CGFloat(colown + 1);
let marginH = marginW;
let cellCount = 100;

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    var collectionView: UICollectionView!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSizeMake(cellWH, cellWH);
        layout.minimumLineSpacing = marginW;
        layout.minimumInteritemSpacing = marginH;
        collectionView = UICollectionView.init(frame: UIScreen.mainScreen().bounds, collectionViewLayout: layout);
        collectionView.backgroundColor = UIColor.whiteColor();
        collectionView.dataSource = self;
        collectionView.delegate = self;
        view.addSubview(collectionView);
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(_:)));
        collectionView.addGestureRecognizer(tap);
        
        // 注册cell
        collectionView.registerClass(ZXCollectionViewCell.self, forCellWithReuseIdentifier: "cell");
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tapAction(tap: UITapGestureRecognizer) -> Void {
        
        for cell in collectionView.visibleCells() {
            
            let cell = cell as!ZXCollectionViewCell;
            cell.layer.speed = 0.0;
            cell.deleteButton.hidden = true;
        }
    }
    
    // MARK: - 返回多少行
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellCount;
    }
    
    // MARK: - 返回cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as!ZXCollectionViewCell;
        cell.backgroundColor = UIColor.cyanColor();
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressClick(_:)));
        
        cell.addGestureRecognizer(longPress);
        return cell;
    }
    
    func longPressClick(longPress: UILongPressGestureRecognizer) -> Void {
        
        for cell in collectionView.visibleCells() {
            
            let cell = cell as!ZXCollectionViewCell;
            cell.layer.speed = 1.0;
            cellShake(cell);
            cell.deleteButton.hidden = false;
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        for cell in collectionView.visibleCells() {
            
            let cell = cell as!ZXCollectionViewCell;
            cell.layer.speed = 0.0;
            cell.deleteButton.hidden = true;
        }
    }
    
    // 抖动
    func cellShake(view: UIView) -> Void {
        
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z");
        // 设置属性，周期时长
        animation.duration = 0.15;
        // 设置抖动角度
        animation.fromValue = CGFloat(-M_1_PI/4);
        animation.toValue = CGFloat(M_1_PI/4);
        // 设置重复次数
        animation.repeatCount = 100000;
        // 恢复原样
        animation.autoreverses = true;
        //锚点设置为图片中心，绕中心抖动
        view.layer.anchorPoint = CGPointMake(0.5, 0.5);
        view.layer.addAnimation(animation, forKey: "rotation");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

