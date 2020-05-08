//
//  ViewController.swift
//  CarouselEffect
//
//  Created by QDSG on 2020/5/7.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    fileprivate var models = Interest.createInterests()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate struct Size {
        static let screenW = UIScreen.main.bounds.width
        static let screenH = UIScreen.main.bounds.height
    }
    
    fileprivate struct StoryBoard {
        static let cellIdentifier = "InterestCellId"
        static let cellPadding: CGFloat = 20
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoard.cellIdentifier,
                                                      for: indexPath) as! CarouselViewCell
        cell.model = models[indexPath.item]
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (Size.screenW - 2 * StoryBoard.cellPadding), height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return StoryBoard.cellPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: StoryBoard.cellPadding, bottom: 0, right: StoryBoard.cellPadding)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let originPoint = targetContentOffset.pointee
        var index = Int(originPoint.x / Size.screenW)
        let offset = Int(originPoint.x) % Int(Size.screenW)
        index += offset > Int(Size.screenW / 2) ? 1 : 0
        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * (Size.screenW - StoryBoard.cellPadding), y: 0)
    }
}

