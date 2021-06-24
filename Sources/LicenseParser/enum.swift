import Foundation

/**
  AAMVA Issuing Countries

  - UnitedStates: The USA
  - Canda: Canada, eh?
  - Unknown: When the issuing country is not available
*/
public enum IssuingCountry: String {
  /// The United States
  case unitedStates

  /// Canada
  case canada

  /// Unknown Issuing Country
  case unknown
}

/**
  AAMVA Genders

  - Male: Male
  - Female: Female
  - Other: Not yet part of the AAMVA spec
  - Unknown: When the gender cannot be determined
*/
public enum Gender: String {
  /// Male
  case male

  /// Female
  case female

  /// Other
  case other

  /// Unknown Gender
  case unknown
}

/**
  AAMVA Eye Colors

  - Black: Black eyes
  - Blue: Blue eyes
  - Brown: Brown eyes
  - Gray: Gray eyes
  - Green: Green eyes
  - Hazel: Hazel eyes
  - Maroon: Maroon eyes
  - Pink: Pink eyes
  - Dichromatic: Dichromatic eyes
  - Unknown: Unknown eye color
*/
public enum EyeColor: String {
  /// Black eye color
  case black
  /// Blue eye color
  case blue
  /// Brown eye color
  case brown
  /// Gray eye color
  case gray
  /// Green eye color
  case green
  /// Hazel eye color
  case hazel
  /// Maroon eye color
  case maroon
  /// Pink eye color
  case pink
  /// Dichromatic eye color
  case dichromatic
  /// Unknown eye color
  case unknown
}

/**
  AAMVA hair colors

  - Bald: Bald hair
  - Black: Black hair
  - Blond: Blond hair
  - Brown: Brown hair
  - Grey: Grey hair
  - Red: Red hair
  - Sandy: Sandy hair
  - White: White hair
  - Unknown: Unknown hair color
*/
public enum HairColor: String {
  /// Bald hair color
  case bald
  /// Black hair color
  case black
  /// Blond hair color
  case blond
  /// Brown hair color
  case brown
  /// Grey hair color
  case grey
  /// Red hair color
  case red
  /// Sandy hair color
  case sandy
  /// White hair color
  case white
  /// Unknown hair color
  case unknown
}

/**
  AAMVA Name Truncations

  - Truncated: The name was truncated
  - None: The name was not truncated
  - Unknown: When the truncation cannot be determined
*/
public enum Truncation: String {
  /// Truncated Name
  case truncated
  /// Not Truncated
  case none
  /// Unknown Truncation
  case unknown
}

/**
  AAMVA Name Suffixes

  - Junior: Junior, Jr.
  - Senior: Senior, Sr.
  - First: First, I, 1st
  - Second: Second, II, 2nd
  - Third: Third, III, 3rd
  - Fourth: Fourth, IV, 4th
  - Fifth: Fifth, V, 5th
  - Sixth: Sixth, VI, 6th
  - Seventh: Seventh, VII, 7th
  - Eighth: Eighth, VIII, 8th
  - Ninth: Ninth, IX, 9th
  - Unknown: When the name suffix is unknown
*/
public enum NameSuffix: String {
  /// Junior, Jr.
  case junior
  /// Senior, Sr.
  case senior
  /// First, I, 1st
  case first
  /// Second, II, 2nd
  case second
  /// Third, III, 3rd
  case third
  /// Fourth, IV, 4th
  case fourth
  /// Fifth, V, 5th
  case fifth
  /// Sixth, VI, 6th
  case sixth
  /// Seventh, VII, 7th
  case seventh
  /// Eighth, VIII, 8th
  case eighth
  /// Ninth, IX, 9th
  case ninth
  /// When the name suffix is unknown
  case unknown
}
