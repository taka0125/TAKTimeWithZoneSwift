import Foundation
import UIKit

extension NSTimeZone {
  class func GMT() -> NSTimeZone {
    return NSTimeZone(abbreviation: "GMT")!
  }
  
  class func JST() -> NSTimeZone {
    return NSTimeZone(abbreviation: "JST")!
  }
}
