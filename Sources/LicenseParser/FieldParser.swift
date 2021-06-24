import Foundation

/// Defines Field Parsing Behavior
public protocol FieldParsing {
  /// A Field Mapping implementing object
  var fieldMapper: FieldMapping { get set }

  /// The AAMVA raw barcode data being parsed
  var data: String { get set }

  /**
    Parse a string out of the raw data

    - Parameters:
      - The human readable key we're looking for

    - Returns: An optional value parsed out of the raw data
  */
  func parseString(key: String) -> String?

  /**
    Parse a double out of the raw data.

    - Parameters:
      - key: The human readable key we're looking for

    - Returns: An optional value parsed out of the raw data
  */
  func parseDouble(key: String) -> Double?

  /**
    Parse a date out of the raw data

    - Parameters:
      - key: The human readable key we're looking for

    - Returns: An optional value parsed out of the raw data
  */
  func parseDate(key: String) -> Date?

  /**
    Parse the AAMVA expiration date out of the raw data

    - Parameters:
      - key: The human readable key we're looking for

    - Returns: An optional value parsed out of the raw data
  */
  func parseExpirationDate() -> Date?

  /**
    Parse the AAMVA issue date out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  func parseIssueDate() -> Date?

  /**
    Parse the AAMVA date of birth out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  func parseDateOfBirth() -> Date?

  /**
    Parse the AAMVA issuing country out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  func parseCountry() -> IssuingCountry

  /**
    Parse the AAMVA name truncation statuses out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  func parseTruncationStatus(field: String) -> Truncation

  /**
    Parse the AAMVA gender out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  func parseGender() -> Gender

  /**
    Parse the AAMVA eye color out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  func parseEyeColor() -> EyeColor

  /**
    Parse the AAMVA name suffix out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  func parseNameSuffix() -> NameSuffix

  /**
    Parse the AAMVA height out of the raw data

    - Returns: An optional value parsed out of the raw data in inches
  */
  func parseHeight() -> Double?

  /**
    Parse the AAMVA hair color out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  func parseHairColor() -> HairColor

  /**
    The string format used with an DateFormatter to parse dates. Usually 'yyyyMMdd' or 'MMddyyyy'.

    - Returns: An DateFormatter formatter string acceptable date format
  */
  func getDateFormat() -> String

  /**
    Parse the AAMVA first name out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  func parseFirstName() -> String?

  /**
    Parse the AAMVA last name out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  func parseLastName() -> String?

  /**
    Parse the AAMVA middle name out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  func parseMiddleName() -> String?
}

/**
  A basic Field Parsing implementation that can be extended to support multiple AAMVA Versions
*/

public class FieldParser: FieldParsing {
  /// Used to convert cm to inches for height calculations
  static let INCHES_PER_CENTIMETER: Double = 0.393_701

  /// A Regex object for doing the heavy lifting
  let regex: Regex = Regex()

  /// A Field Mapping object for finding fields in the raw data
  public var fieldMapper: FieldMapping

  /// The raw data from an AAMVA spec adhering PDF-417 barcode
  public var data: String

  /**
    Initializes a new Field Parser

    - Parameters:
      - data: The AAMVA spec adhering PDF-417 barcode data
      - fieldMapper: A FieldMapping object

    - Returns: An initialized Field Parser
  */
  public init(data: String, fieldMapper: FieldMapping) {
    self.data = data
    self.fieldMapper = fieldMapper
  }

  /**
    Initializes a new Field Parser defaulting to the basic FieldMapper

    - Parameters:
      - data: The AAMVA spec adhering PDF-417 barcode data

    - Returns: An initialized Field Parser
  */
  public convenience init(data: String) {
    self.init(data: data, fieldMapper: FieldMapper())
  }

  /**
    Parse a string out of the raw data

    - Parameters:
      - The human readable key we're looking for

    - Returns: An optional value parsed out of the raw data
  */

  public func parseString(key: String) -> String? {
    let identifier = fieldMapper.fieldFor(key: key)
    return regex.firstMatch(pattern: "\(identifier)(.+)\\b", data: data)
  }

  /**
    Parse a double out of the raw data.

    - Parameters:
      - The human readable key we're looking for

    - Returns: An optional value parsed out of the raw data
  */
  public func parseDouble(key: String) -> Double? {
    let identifier = fieldMapper.fieldFor(key: key)
    let result = regex.firstMatch(pattern: "\(identifier)(\\w+)\\b", data: data)
    guard let unwrappedResult = result else { return nil }

    return Double(unwrappedResult)
  }

  /**
    Parse a date out of the raw data

    - Parameters:
      - The human readable key we're looking for

    - Returns: An optional value parsed out of the raw data
  */
  public func parseDate(key field: String) -> Date? {
    guard let dateString = parseString(key: field) else { return nil }
    guard !dateString.isEmpty else { return nil }

    let formatter = DateFormatter()
    formatter.dateFormat = getDateFormat()
    guard let parsedDate = formatter.date(from: dateString) else { return nil }

    return parsedDate as Date
  }

  /**
    The string format used with an DateFormatter to parse dates. Usually 'yyyyMMdd' or 'MMddyyyy'.

    - Returns: An DateFormatter formatter string acceptable date format
  */
  public func getDateFormat() -> String {
    return "MMddyyyy"
  }

  /**
    Parse the AAMVA last name out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  public func parseFirstName() -> String? {
    return parseString(key: "firstName")
  }

  /**
    Parse the AAMVA last name out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  public func parseLastName() -> String? {
    return parseString(key: "lastName")
  }

  /**
    Parse the AAMVA middle name out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  public func parseMiddleName() -> String? {
    let middleName = parseString(key: "middleName")
    return middleName?.caseInsensitiveCompare("NONE") == .orderedSame ? nil : middleName
  }

  /**
    Parse the AAMVA expiration date out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  public func parseExpirationDate() -> Date? {
    return parseDate(key: "expirationDate")
  }

  /**
    Parse the AAMVA issue date out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  public func parseIssueDate() -> Date? {
    return parseDate(key: "issueDate")
  }

  /**
    Parse the AAMVA date of birth out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  public func parseDateOfBirth() -> Date? {
    return parseDate(key: "dateOfBirth")
  }

  /**
    Parse the AAMVA issuing country out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  public func parseCountry() -> IssuingCountry {
    guard let country = parseString(key: "country") else { return .unknown }
    switch country {
    case "USA":
      return .unitedStates
    case "CAN":
      return .canada
    default:
      return .unknown
    }
  }

  /**
    Parse the AAMVA name truncation statuses out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  public func parseTruncationStatus(field: String) -> Truncation {
    guard let truncation = parseString(key: field) else { return .unknown }

    switch truncation {
    case "T":
      return .truncated
    case "N":
      return .none
    default:
      return .unknown
    }
  }

  /**
    Parse the AAMVA gender out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  public func parseGender() -> Gender {
    guard let gender = parseString(key: "gender") else { return .unknown }
    switch gender {
    case "1":
      return .male
    case "2":
      return .female
    default:
      return .other
    }
  }

  /**
    Parse the AAMVA eye color out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  public func parseEyeColor() -> EyeColor {
    guard let color = parseString(key: "eyeColor") else { return .unknown }
    switch color {
    case "BLK":
      return .black
    case "BLU":
      return .blue
    case "BRO":
      return .brown
    case "GRY":
      return .gray
    case "GRN":
      return .green
    case "HAZ":
      return .hazel
    case "MAR":
      return .maroon
    case "PNK":
      return .pink
    case "DIC":
      return .dichromatic
    default:
      return .unknown
    }
  }

  /**
    Parse the AAMVA name suffix out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  public func parseNameSuffix() -> NameSuffix {
    guard let suffix = parseString(key: "suffix") else { return .unknown }

    switch suffix {
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

  /**
    Parse the AAMVA hair color out of the raw data

    - Returns: An optional value parsed out of the raw data
  */
  public func parseHairColor() -> HairColor {
    guard let color = parseString(key: "hairColor") else { return .unknown }

    switch color {
    case "BAL":
      return .bald
    case "BLK":
      return .black
    case "BLN":
      return .blond
    case "BRO":
      return .brown
    case "GRY":
      return .grey
    case "RED":
      return .red
    case "SDY":
      return .sandy
    case "WHI":
      return .white
    default:
      return .unknown
    }
  }

  /**
    Parse the AAMVA height out of the raw data

    - Returns: An optional value parsed out of the raw data in inches
  */
  public func parseHeight() -> Double? {
    guard let heightString = parseString(key: "height") else { return nil }
    guard let height = parseDouble(key: "height") else { return nil }

    if heightString.contains("cm") {
      return Double(round(height * FieldParser.INCHES_PER_CENTIMETER))
    } else {
      return height
    }
  }
}
