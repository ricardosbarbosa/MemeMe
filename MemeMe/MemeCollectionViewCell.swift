//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Ricardo Barbosa on 11/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imageMeme: UIImageView!
  
  var meme : Meme? {
    didSet {
      updateUI()
    }
  }
  
  func updateUI() {
    if let meme = meme {
      imageMeme.image = meme.memedImage
    }
  }
}
