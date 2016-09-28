//
//  ZXCollectionViewCell.swift
//  ShakeCollectionView
//
//  Created by zhangxu on 16/9/27.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXCollectionViewCell: UICollectionViewCell {
    
    var deleteButton: UIButton!;
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.layer.cornerRadius = 20;
        
        let width = frame.size.width;
        
        deleteButton = UIButton(type: .Custom);
        deleteButton.setImage(UIImage(named: "deleteBtn.png"), forState: UIControlState.Normal);
        deleteButton.hidden = true;
        deleteButton.frame = CGRectMake(width - 13, -13, 26, 26)
        contentView.addSubview(deleteButton);

        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
