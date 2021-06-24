//
//  VersionFiveParserSpec.swift
//  LicenseParser
//
//  Created by Clayton Lengel-Zigich on 6/15/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import LicenseParser

class VersionFiveParserSpec: QuickSpec{
  override func spec(){
    describe("Parsing AAMVA 2010 DL/ID Card Standard aka Version 5"){
      it("should correctly parse all available fields"){
        let sut = Parser(data: self.licenseData())
        let result = sut.parse()

        expect(result.firstName).to(equal("JOHN"))
        expect(result.firstNameAlias).to(beNil())
        expect(result.firstNameTruncation).to(equal(Truncation.unknown))
        expect(result.lastName).to(equal("PUBLIC"))
        expect(result.lastNameAlias).to(beNil())
        expect(result.lastNameTruncation).to(equal(Truncation.unknown))
        expect(result.middleName).to(equal("QUINCY"))
        expect(result.middleNameTruncation).to(equal(Truncation.unknown))
        expect(result.expirationDate).to(equal(self.dateFromString("08112019", dateFormat: "MMddyyyy")))
        expect(result.issueDate).to(equal(self.dateFromString("10092015", dateFormat: "MMddyyyy")))
        expect(result.gender).to(equal(Gender.male))
        expect(result.eyeColor).to(equal(EyeColor.brown))
        expect(result.height).to(equal(69))
        expect(result.streetAddress).to(equal("454 APRICOT RD"))
        expect(result.city).to(equal("LITTLE ROCK"))
        expect(result.state).to(equal("AR"))
        expect(result.postalCode).to(equal("11111 2222"))
        expect(result.customerId).to(equal("123456789"))
        expect(result.documentId).to(beNil())
        expect(result.country).to(equal(IssuingCountry.unitedStates))
        expect(result.streetAddressSupplement).to(beNil())
        expect(result.hairColor).to(equal(HairColor.unknown))
        expect(result.dateOfBirth).to(equal(self.dateFromString("08111972", dateFormat: "MMddyyyy")))
        expect(result.auditInformation).to(beNil())
        expect(result.inventoryControlNumber).to(beNil())
        expect(result.suffixAlias).to(beNil())
        expect(result.suffix).to(equal(NameSuffix.unknown))
        expect(result.version).to(equal("05"))
      }
    }
  }

  func dateFromString(_ dateString: String, dateFormat: String) -> Date?{
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    guard let parsedDate = formatter.date(from: dateString) else { return nil }

    return parsedDate
  }

  func licenseData() -> String{
    let data: String  = "@\n" +
      "\n" +
      "ANSI 636021050002DL00410229ZA02700014DLDCB\n" +
      "DAQ123456789\n" +
      "DCAD\n" +
      "DAK11111 2222 \n" +
      "DAJAR\n" +
      "DAILITTLE ROCK\n" +
      "DAG454 APRICOT RD\n" +
      "DDGU\n" +
      "DDFU\n" +
      "DADQUINCY\n" +
      "DDEU\n" +
      "DACJOHN\n" +
      "DDD0\n" +
      "DDB09152012\n" +
      "DDAN\n" +
      "DBD10092015\n" +
      "DCSPUBLIC\n" +
      "DBC1\n" +
      "DBB08111972\n" +
      "DBA08112019\n" +
      "DCLW\n" +
      "DCK\n" +
      "DAYBRO\n" +
      "DCGUSA\n" +
      "DCF\n" +
      "DAU069 in\n" +
      "DCDM\n" +
      "ZAZAB6003\n" +
      "ZAA\n"

    return data
  }
}
