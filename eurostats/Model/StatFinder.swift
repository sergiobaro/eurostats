import Foundation

struct StatFinder {
  
  private let stat: StatData
  
  init(stat: StatData) {
    self.stat = stat
  }
  
  // MARK: - Public
  
  func value(index: [Int]) -> Double? {
    guard let flatIndex = calculateFlatIndex(index: index) else {
      return nil
    }
    
    return self.stat.value[flatIndex]
  }
  
  func status(index: [Int]) -> String? {
    guard let status = stat.status else {
      return nil
    }
    guard let flatIndex = calculateFlatIndex(index: index) else {
      return nil
    }
    
    return status[flatIndex]
  }
  
  // MARK: - Private
  
  private func calculateFlatIndex(index: [Int]) -> String? {
    guard index.count == self.stat.id.count else {
      return nil
    }
    let sizes = stat.size
    
    let intIndex = index.enumerated().reduce(0, { total, element -> Int in
      let i = element.0
      let value = element.1
      let size = (i + 1 < sizes.count ? sizes[i + 1] : 1)
      
      return size * (value + total)
    })
    
    return String(intIndex)
  }
  
}
