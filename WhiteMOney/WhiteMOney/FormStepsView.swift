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
        let size = CGSize.init(width: (self.frame.size.width/CGFloat(items.count))-10, height: self.frame.size.height)
        hilightLbl?.frame = CGRect.init(x: 5, y: 0, width: size.width, height: size.height)

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
        var stepNum = step-1
        selectedIndex = stepNum
        let attributes = collectionView?.layoutAttributesForItem(at: IndexPath.init(row: stepNum, section: 0))
        let cellFrame = collectionView?.convert((attributes?.frame)!, to: collectionView?.superview)
        UIView.animate(withDuration: 0.5) {
        }
        UIView.animate(withDuration: 0.1, animations: {
            self.hilightLbl?.frame = cellFrame!
        })
        self.collectionView?.reloadData()

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
        return CGSize.init(width: (self.frame.size.width/CGFloat(items.count))-10, height: self.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for:indexPath) as! StepsItemCell
        let titleLbl = cell.viewWithTag(100) as! UILabel
        if selectedIndex == indexPath.row {
            titleLbl.textColor = UIColor.appBlue
        }else{
            titleLbl.textColor = UIColor.white
        }
        titleLbl.text = items[indexPath.row]
        cell.contentView.backgroundColor = UIColor.clear
        return cell
    }
    
}


