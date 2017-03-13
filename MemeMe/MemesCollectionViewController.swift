//
//  MemesCollectionViewController.swift
//  MemeMe
//
//  Created by Ricardo Barbosa on 11/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit

extension MemesCollectionViewController : MemeViewControllerProtocol {
  func added(controller: MemeEditorViewController, meme: Meme) {
    listOfMemes.addMeme(meme)
  }
}

extension MemesCollectionViewController : ListOfMemesProtocol {
  func added(ListOfMemes: ListOfMemes) {
    self.collectionView?.reloadData()
  }
}

private let reuseIdentifier = "Cell"

class MemesCollectionViewController: UICollectionViewController {

  var listOfMemes : ListOfMemes = ListOfMemes.sharedInstance
  
  override func viewDidLoad() {
    super.viewDidLoad()
    listOfMemes.addObserve(observer: self)
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? MemeEditorViewController {
      vc.memeViewControllerProtocol = self
    }
    
    if let vc = segue.destination as? MemeDetailViewController {
      vc.meme = (sender as! MemeCollectionViewCell).meme
    }
  }
  

  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return listOfMemes.memes.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
    cell.meme = listOfMemes.memes[indexPath.row]
    return cell
  }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
