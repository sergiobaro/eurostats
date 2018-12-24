import Foundation

struct StatExtension: Codable {
  
  let datasetId: String
  let lang: String
  let status: StatStatus
  
}

struct StatStatus: Codable {
  
  let label: [String: String]
  
}

struct StatDimension: Codable {
  
  let label: String
  let category: StatCategory
  
}

struct StatCategory: Codable {
  
  let index: [String: Int]
  let label: [String: String]
  
}

struct StatData: Codable {
  
  let version: String
  let label: String
  let source: String
  let updated: String
  let `class`: String
  let `extension`: StatExtension
  let id: [String]
  let size: [Int]
  
  let status: [String: String]
  let value: [String: Int]
  
  let dimension: [String: StatDimension]
  
}
