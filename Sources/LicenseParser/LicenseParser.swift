import Foundation

/// A Parser for creating ParsedLicense objects
public class Parser {
  let regex: Regex = Regex()

  /// The AAMVA PDF417 raw barcode data being used for parsing
  public var data: String

  /// The FieldParsing object to aide in parsing individual fields
  public var fieldParser: FieldParsing

  /**
    Initializes a new Parser

    - Parameters:
      - data: The AAMVA PDF417 raw barcode data

    - Returns: A configured Parser ready to parse and generate a ParsedLicense
  */
  public init(data: String) {
    self.data = data
    self.fieldParser = FieldParser(data: data)
  }

  /**
    Parses the AAMVA PDF417 raw barcode data based on the specific AAMVA document version

    - Returns: A ParsedLicense with all available parsed fields
  */
  public func parse() -> ParsedLicense {
    self.fieldParser = versionBasedFieldParsing(version: parseVersion())

    return License(
      firstName : fieldParser.parseFirstName(),
      lastName : fieldParser.parseLastName(),
      middleName : fieldParser.parseMiddleName(),
      expirationDate : fieldParser.parseExpirationDate(),
      issueDate : fieldParser.parseIssueDate(),
      dateOfBirth : fieldParser.parseDateOfBirth(),
      gender : fieldParser.parseGender(),
      eyeColor : fieldParser.parseEyeColor(),
      height : fieldParser.parseHeight(),
      streetAddress : fieldParser.parseString(key: "streetAddress"),
      city : fieldParser.parseString(key: "city"),
      state : fieldParser.parseString(key: "state"),
      postalCode : fieldParser.parseString(key: "postalCode"),
      customerId : fieldParser.parseString(key: "customerId"),
      documentId : fieldParser.parseString(key: "documentId"),
      country : fieldParser.parseCountry(),
      middleNameTruncation : fieldParser.parseTruncationStatus(field: "middleNameTruncation"),
      firstNameTruncation : fieldParser.parseTruncationStatus(field: "firstNameTruncation"),
      lastNameTruncation : fieldParser.parseTruncationStatus(field: "lastNameTruncation"),
      streetAddressSupplement : fieldParser.parseString(key: "streetAddressSupplement"),
      hairColor : fieldParser.parseHairColor(),
      placeOfBirth : fieldParser.parseString(key: "placeOfBirth"),
      auditInformation : fieldParser.parseString(key: "auditInformation"),
      inventoryControlNumber : fieldParser.parseString(key: "inventoryControlNumber"),
      lastNameAlias : fieldParser.parseString(key: "lastNameAlias"),
      firstNameAlias : fieldParser.parseString(key: "firstNameAlias"),
      suffixAlias : fieldParser.parseString(key: "suffixAlias"),
      suffix : fieldParser.parseNameSuffix(),
      version : parseVersion(),
      pdf417 : data
    )
  }

  private func versionBasedFieldParsing(version: String?) -> FieldParser {
    let defaultParser = FieldParser(data: self.data)

    guard let v = version else { return defaultParser }

    switch v {
    case "01":
      return VersionOneFieldParser(data: self.data)
    case "02":
      return VersionTwoFieldParser(data: self.data)
    case "03":
      return VersionThreeFieldParser(data: self.data)
    case "04":
      return VersionFourFieldParser(data: self.data)
    case "05":
      return VersionFiveFieldParser(data: self.data)
    case "08":
      return VersionEightFieldParser(data: self.data)
    default:
      return defaultParser
    }
  }

  private func parseVersion() -> String? {
    return regex.firstMatch(pattern: "\\d{6}(\\d{2})\\w+", data: data)
  }
}
