//
//  FormStepsView.swift
//  WhiteMOney
//
//  Created by Venkatesh on 30/09/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class FormStepsView: UIView {
    var items : [String]  {
        didSet{
            collectionView?.reloadData()
        }
    }
    var selectedIndex = 0
    private var collectionView : UICollectionView?
    private var hilightLbl : UILabel?
    
    
    
    public override init(frame: CGRect) {
        self.items = [String]()
        super.init(frame: frame)
        setupConstraints()
    }
    
    override func layoutSubviews() {
        collectionView?.reloadData()
        hilightLbl?.layer.cornerRadius = (self.frame.size.height/2) - 10
        let size = cellSize
        hilightLbl?.frame = CGRect.init(x: 10, y: 0, width: size.width, height: size.height)

    }
    required init?(coder aDecoder: NSCoder) {
        self.items = [String]()
        super.init(coder: aDecoder)
        initializeUi()
    }
    func initializeUi() -> Void {
        self.backgroundColor = UIColor.clear
        hilightLbl = UILabel()
        hilightLbl?.frame = CGRect.init(x: 0, y: 0, width: 0, height: 0)
        hilightLbl?.backgroundColor = UIColor.white
        hilightLbl?.layer.masksToBounds = true

        self.addSubview(hilightLbl!)
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        self.addSubview(collectionView!)

        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView?.backgroundColor = UIColor.lightGray
//        collectionView?.register(StepsItemCell.self, forCellWithReuseIdentifier: "item")
        collectionView?.register(UINib(nibName: "StepsItemCell", bundle: nil), forCellWithReuseIdentifier: "item")

        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.isScrollEnabled = false
        setupConstraints()
    }
    
    func setupConstraints() -> Void {
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        _ = collectionView?.setTopAnc(self.topAnchor, withConst: 5.0)
        _ = collectionView?.setBottomAnc(self.bottomAnchor, withConst: 5.0)
        _ = collectionView?.setLeadingAnc(self.leadingAnchor, withConst: 5.0)
        _ = collectionView?.setTrailingAnc(self.trailingAnchor, withConst: 5.0)
        collectionView?.layoutIfNeeded()
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func chaangeStepTo(_ step : Int) -> Void {
        var stepNum = step
        selectedIndex = stepNum
        collectionView?.scrollToItem(at: IndexPath.init(row: stepNum, section: 0), at: .centeredHorizontally, animated: false)

        let attributes = collectionView?.layoutAttributesForItem(at: IndexPath.init(row: stepNum, section: 0))
        if let cellFrame = collectionView?.convert((attributes?.frame)!, to: collectionView?.superview){
            var newFrame = CGRect.init(origin: cellFrame.origin, size: cellFrame.size)
            newFrame.origin.x = (cellFrame.origin.x)  + CGFloat(5.0)
            UIView.animate(withDuration: 0.1, animations: {
                self.hilightLbl?.frame = newFrame
            })
        }
 
        self.collectionView?.reloadData()

    }
    var cellSize : CGSize {
        get{
            var size = CGSize.init(width: (self.frame.size.width/CGFloat(items.count))-10, height: self.frame.size.height)
            if size.width > 150 {
                return size
            }
            size.width = 150.0
            return size
        }
    }
}
extension FormStepsView:  UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for:indexPath) as! StepsItemCell
        let titleLbl = cell.viewWithTag(100) as! UILabel
        titleLbl.adjustsFontSizeToFitWidth = true
        if selectedIndex == indexPath.row {
            titleLbl.textColor = UIColor.primaryBrandingColor()
        }else{ 
            titleLbl.textColor = UIColor.white
        }
        titleLbl.text = items[indexPath.row]
        cell.contentView.backgroundColor = UIColor.clear
        return cell
    }
    
}


