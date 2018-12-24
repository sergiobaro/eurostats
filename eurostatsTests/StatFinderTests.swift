import XCTest
@testable import eurostats

class StatFinderTests: XCTestCase {
  
  // MARK: - Tests
  
  func testFinderTrainData() {
    let finder = self.finder(json: "tran_sf_railac")
    
    // total, belgium, 2007
    XCTAssertEqual(finder.value(index: [0, 6, 1, 1]), 217)
    XCTAssertEqual(finder.status(index: [0, 6, 1, 1]), nil)
    
    // total, montenegro, 2011
    XCTAssertEqual(finder.value(index: [0, 6, 21, 5]), nil)
    XCTAssertEqual(finder.status(index: [0, 6, 21, 5]), ":")
  }
  
  func testFinderTradeData() {
    let finder = self.finder(json: "ext_lt_introle")
    
    // exports, total, us, 2008
    XCTAssertEqual(finder.value(index: [1, 7, 10, 6]), 883_804.0)
  }
  
  // MARK: - Helpers
  
  func finder(json: String) -> StatFinder {
    let data = self.load(json: json)!
    let stat = try! JSONDecoder().decode(StatData.self, from: data)
    return StatFinder(stat: stat)
  }
  
  func load(json: String) -> Data? {
    let bundle = Bundle(for: StatFinderTests.self)
    guard let url = bundle.url(forResource: json, withExtension: "json") else {
      return nil
    }
    
    return try? Data(contentsOf: url)
  }
  
}
