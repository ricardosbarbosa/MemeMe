//
//  ListOfMemes.swift
//  MemeMe
//
//  Created by Ricardo Barbosa on 11/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit

protocol ListOfMemesProtocol {
  func added(ListOfMemes: ListOfMemes)
}
class ListOfMemes: NSObject {
  static let sharedInstance = ListOfMemes()
  
  private(set) var memes : [Meme] = []
    
  private var observers : [ListOfMemesProtocol] = []
  
  private override init() {}
  
  func addObserve(observer: ListOfMemesProtocol) {
    observers.append(observer)
  }
  
  func addMeme(_ meme: Meme) {
    memes.append(meme)
    
    for o in observers {
      o.added(ListOfMemes: self)
    }
  }
}
