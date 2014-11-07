import Foundation
import UIKit

extension NSDate {
  func isEailerThan(another: NSDate) -> Bool {
    let result = compare(another)
    switch result {
    case .OrderedSame, .OrderedDescending:
      return false
    case .OrderedAscending:
      return true
    }
  }
  
  func isLaterThan(another: NSDate) -> Bool {
    let result = compare(another)
    switch result {
    case .OrderedSame, .OrderedAscending:
      return false
    case .OrderedDescending:
      return true
    }
  }
}
