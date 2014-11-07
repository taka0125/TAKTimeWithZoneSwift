import Foundation

extension Int {
  func seconds() -> Int {
    return self
  }
  
  func minutes() -> Int {
    return self * 60
  }

  func hours() -> Int {
    return self * 3600
  }
  
  func days() -> Int {
    return self * 24.hours()
  }
  
  func weeks() -> Int {
    return self * 7.days()
  }
  
  func second() -> Int {
    return seconds()
  }
  
  func minute() -> Int {
    return minutes()
  }
  
  func hour() -> Int {
    return hours()
  }
  
  func day() -> Int {
    return days()
  }
  
  func week() -> Int {
    return weeks()
  }
  
  func fromNowInGMT() -> TimeWithZone {
    return from(TimeWithZone.nowInGMT())
  }
  
  func from(time: TimeWithZone) -> TimeWithZone {
    return time.since(self)
  }

  func ago() -> Int {
    return -self
  }
}
