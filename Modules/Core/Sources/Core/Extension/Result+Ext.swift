//
//  Result+Ext.swift
//  Core
//
//  Created by User on 27/01/26.
//
import RealmSwift

public extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

  func toArray<T>(ofType: T.Type, limits: Int) -> [T] {
    var array = [T]()
    if count != 0 {
      for index in 0 ..< limits {
        if let result = self[index] as? T {
          array.append(result)
        }
      }
    }
    return array
  }
}
