import Foundation
import UIKit

class TimeWithZone {
  let timestamp: NSTimeInterval
  let zone: NSTimeZone
  let date: NSDate
  
  lazy private var calendar: NSCalendar = self.buildCalendar()
  
  init(_ timestamp: NSTimeInterval, _ zone: NSTimeZone) {
    self.timestamp = timestamp
    self.zone = zone
    self.date = NSDate(timeIntervalSince1970: timestamp)
  }
  
  // now in GMT
  class func nowInGMT() -> TimeWithZone {
    let nowInGMT = NSDate().timeIntervalSince1970
    return TimeWithZone(nowInGMT, NSTimeZone.GMT())
  }
  
  func inTimeZone(zone: NSTimeZone) -> TimeWithZone {
    if self.zone == zone { return self }
    return TimeWithZone(timestamp, zone)
  }
  
  func isBetween(min: TimeWithZone, _ max: TimeWithZone) -> Bool {
    if timestamp < min.timestamp { return false }
    if timestamp > max.timestamp { return false }
    return true
  }
  
  func since(seconds: Int) -> TimeWithZone {
    return TimeWithZone(timestamp + NSTimeInterval(seconds), zone)
  }
  
  func ago(seconds: Int) -> TimeWithZone {
    return since(-seconds)
  }
  
  func yearsSince(years: Int) -> TimeWithZone {
    return advance(year: years)
  }
  
  func yearsAgo(years: Int) -> TimeWithZone {
    return advance(year: -years)
  }
  
  func advance(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> TimeWithZone {
    let componets = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: date)
    var newComponets = NSDateComponents()
    newComponets.year = componets.year
    newComponets.month = componets.month
    newComponets.day = componets.day
    newComponets.hour = componets.hour
    newComponets.minute = componets.minute
    newComponets.second = componets.second
    
    newComponets.year += year ?? 0
    newComponets.month += month ?? 0
    newComponets.day += day ?? 0
    newComponets.hour += hour ?? 0
    newComponets.minute += minute ?? 0
    newComponets.second += second ?? 0
    
    let newTimestamp = calendar.dateFromComponents(newComponets)!.timeIntervalSince1970

    return TimeWithZone(newTimestamp, zone)
  }
  
  func change(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> TimeWithZone {
    let componets = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: date)
    var newComponets = NSDateComponents()
    newComponets.year = year ?? componets.year
    newComponets.month = month ?? componets.month
    newComponets.day = day ?? componets.day
    newComponets.hour = hour ?? componets.hour
    newComponets.minute = minute ?? componets.minute
    newComponets.second = second ?? componets.second
    
    let newTimestamp = calendar.dateFromComponents(newComponets)!.timeIntervalSince1970
    
    return TimeWithZone(newTimestamp, zone)
  }
  
  func beginningOfDay() -> TimeWithZone {
    return change(hour: 0, minute: 0, second: 0)
  }
  
  func endOfDay() -> TimeWithZone {
    return change(hour: 23, minute: 59, second: 59)
  }
  
  func strftime(format: String = "yyyy-MM-dd HH:mm zzz") -> String {
    let formatter = NSDateFormatter()
    formatter.dateFormat = format
    formatter.timeZone = zone
    return formatter.stringFromDate(date)
  }
  
  private func buildCalendar() -> NSCalendar {
    let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
    calendar.timeZone = zone
    return calendar
  }
}
