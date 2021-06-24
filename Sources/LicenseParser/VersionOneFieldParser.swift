//
//  VersionOneFieldParser.swift
//  Pods
//
//  Created by Clayton Lengel-Zigich on 6/10/16.
//
//

import Foundation

class VersionOneFieldMapper: FieldMapper {
  override init() {
    super.init()

    self.fields["customerId"] = "DBJ"
    self.fields["lastName"] = "DAB"
    self.fields["driverLicenseName"] = "DAA"
  }
}

class VersionOneFieldParser: FieldParser {
  convenience init(data: String) {
    self.init(data: data, fieldMapper: VersionOneFieldMapper())
  }

  override func getDateFormat() -> String {
    return "yyyyMMdd"
  }

  override func parseFirstName() -> String? {
    guard let firstDriverLicenseName = parseString(key: "firstName") else { return parseDriverLicenseName(key: "firstName") }
    return firstDriverLicenseName
  }

  override func parseLastName() -> String? {
    guard let lastDriverLicenseName = parseString(key: "lastName") else { return parseDriverLicenseName(key: "lastName") }
    return lastDriverLicenseName
  }

  override func parseMiddleName() -> String? {
    guard let middleDriverLicenseName = parseString(key: "middleName") else { return parseDriverLicenseName(key: "middleName") }
    return middleDriverLicenseName
  }

  // Parse something like 508 (5'8") into 68"
  override func parseHeight() -> Double? {
    guard let heightInFeetAndInches = parseString(key: "height") else { return nil }
    guard let height = regex.firstMatch(pattern: "([0-9]{1})", data: heightInFeetAndInches) else { return nil }
    guard let inches = regex.firstMatch(pattern: "[0-9]{1}([0-9]{2})", data: heightInFeetAndInches) else { return nil }

    guard !height.isEmpty else { return nil }
    guard !inches.isEmpty else { return nil }

    let calculatedHeight = (Double(height)! * 12) + Double(inches)!

    if heightInFeetAndInches.contains("cm") {
      return Double(round(calculatedHeight * FieldParser.INCHES_PER_CENTIMETER))
    } else {
      return calculatedHeight
    }
  }

  override func parseNameSuffix() -> NameSuffix {
    var suffix: String? = ""
    if parseString(key: "suffix") != nil {
      suffix = parseString(key: "suffix")
    }

    if parseDriverLicenseName(key: "suffix") != nil {
      suffix = parseDriverLicenseName(key: "suffix")
    }

    guard let nameSuffix = suffix else { return .unknown }

    switch nameSuffix {
    case "JR":
      return .junior
    case "SR":
      return .senior
    case "1ST", "I":
      return .first
    case "2ND", "II":
      return .second
    case "3RD", "III":
      return .third
    case "4TH", "IV":
      return .fourth
    case "5TH", "V":
      return .fifth
    case "6TH", "VI":
      return .sixth
    case "7TH", "VII":
      return .seventh
    case "8TH", "VIII":
      return .eighth
    case "9TH", "IX":
      return .ninth
    default:
      return .unknown
    }
  }

  private func parseDriverLicenseName(key: String) -> String? {
    guard let driverLicenseName = parseString(key: "driverLicenseName") else { return nil }

    let namePieces = driverLicenseName.split { $0 == "," }.map(String.init)

    switch key {
    case "lastName":
      guard namePieces.indices.contains(0) else { return nil }
      return namePieces[0]
    case "firstName":
      guard namePieces.indices.contains(1) else { return nil }
      return namePieces[1]
    case "middleName":
      guard namePieces.indices.contains(2) else { return nil }
      return namePieces[2]
    case "suffix":
      guard namePieces.indices.contains(3) else { return nil }
      return namePieces[3]
    default:
      return nil
    }
  }
}
