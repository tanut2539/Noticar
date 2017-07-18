//
//  CollectionView.swift
//  Noticar
//
//  Created by Tanut.leel on 11/17/2559 BE.
//  Copyright © 2559 Tanut Leelaparsert. All rights reserved.
//

import UIKit
import Material


// MARK:- UICollectionView DataSource

extension MapsViewController: UICollectionViewDataSource {
    
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.cellImage.image = UIImage(named: "\(placeImg[indexPath.row])")
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = getIndexPathForSelectedCell() {
            
            let detailsViewController = segue.destination
            detailsViewController.navigationItem.title = placeTitle[indexPath.row]
            detailsViewController.navigationItem.detail = placeDetail[indexPath.row]
        }
    }
    
    func getIndexPathForSelectedCell() -> IndexPath? {
        
        var indexPath:IndexPath?
        
        if showPlaces.indexPathsForSelectedItems!.count > 0 {
            indexPath = showPlaces.indexPathsForSelectedItems![0]
        }
        return indexPath
    }

}
