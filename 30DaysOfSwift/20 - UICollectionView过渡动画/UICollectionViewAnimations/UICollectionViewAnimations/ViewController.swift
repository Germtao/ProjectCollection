//
//  ViewController.swift
//  UICollectionViewAnimations
//
//  Created by TT on 2020/5/17.
//  Copyright © 2020 tao Tao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private struct Constants {
        static let AnimationDuration: Double = 0.5
        static let AnimationDelay: Double = 0.0
        static let AnimationSpringDamping: CGFloat = 1.0
        static let AnimationInitialSpringVelocity: CGFloat = 1.0
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: AnimationCell.className, bundle: nil), forCellWithReuseIdentifier: AnimationCell.reuseIdentifier)
        }
    }
    
    let viewModel = AnimationCellViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimationCell.reuseIdentifier, for: indexPath) as? AnimationCell else {
            return UICollectionViewCell()
        }
        cell.prepareCell(viewModel.data[indexPath.item])
        
        cell.backClosure = {
            self.backBtnDidTapped()
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AnimationCell else { return }
        
        handlerAnimationCellSelected(collectionView, cell: cell)
    }
    
    private func handlerAnimationCellSelected(_ collectionView: UICollectionView, cell: AnimationCell) {
        cell.handerCellSelected()
        
        let animations = {
            cell.frame = collectionView.bounds
        }
        
        let completion: (_ finished: Bool) -> Void = { _ in
            collectionView.isScrollEnabled = false
        }
        
        UIView.animate(withDuration: Constants.AnimationDuration,
                       delay: Constants.AnimationDelay,
                       usingSpringWithDamping: Constants.AnimationSpringDamping,
                       initialSpringVelocity: Constants.AnimationInitialSpringVelocity,
                       options: [],
                       animations: animations,
                       completion: completion)
    }
    
    private func backBtnDidTapped() {
        guard let indexPaths = collectionView.indexPathsForSelectedItems else { return }
        collectionView.isScrollEnabled = true
        collectionView.reloadItems(at: indexPaths)
    }
}

