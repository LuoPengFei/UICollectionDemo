//
//  LPFCollectionViewCell.swift
//  UICollectionDemo
//
//  Created by Pengfei_Luo on 16/2/16.
//  Copyright © 2016年 骆朋飞. All rights reserved.
//

import UIKit

class LPFCollectionViewCell: UICollectionViewCell {
    var titleLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabel() {
        titleLabel = UILabel()
        titleLabel?.textAlignment = .Center
        titleLabel?.font = UIFont.systemFontOfSize(14)
        self.contentView.addSubview(titleLabel!)
    }
    
    override func layoutSubviews() {
        titleLabel?.center = self.contentView.center
        titleLabel?.bounds = self.bounds
    }
    
    internal func setTitle(title : String) {
        titleLabel?.text = title
    }
}
