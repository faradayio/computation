Feature: Computation Emissions Calculations
  The computation model should generate correct emission calculations

  Background:
    Given a Computation

  Scenario: Default
    Given a computation has nothing
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "0.07"

  Scenario Outline: Calculations from date and duration
    Given it has "date" of "<date>"
    And it has "duration" of "3600000"
    And it is the year "2010"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "<emission>"
    Examples:
      | date       | emission |
      | 2009-06-25 |  0.0     |
      | 2010-06-25 | 67.36    |
      | 2011-06-25 |  0.0     |

  Scenario Outline: Calculations from date, timeframe, and duration
    Given it has "date" of "2009-06-25"
    And it has "timeframe" of "<timeframe>"
    And it has "duration" of "3600000"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "<emission>"
    Examples:
      | timeframe             | emission |
      | 2009-01-01/2009-01-31 |  0.0     |
      | 2009-01-01/2009-12-31 | 67.36    |
      | 2009-12-01/2009-12-31 |  0.0     |

  Scenario: Calculations from carrier instance class and duration
    Given it has "carrier_instance_class.name" of "Amazon m1.large"
    And it has "duration" of "3600000"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "269.44"

  Scenario: Calculations from carrier and duration
    Given it has "carrier.name" of "Amazon"
    And it has "duration" of "3600000"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "67.36"

  Scenario: Calculations from carrier region and duration
    Given it has "carrier_region.name" of "Amazon us-east-1a"
    And it has "duration" of "3600000"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "80.14"

  Scenario: Calculations from zip code and duration
    Given it has "zip_code.name" of "94122"
    And it has "duration" of "3600000"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "49.13"

  Scenario: Calculations from electricity intensity, power usage effectiveness, and duration
    Given it has "electricity_intensity" of "0.5"
    And it has "power_usage_effectiveness" of "2.0"
    And it has "duration" of "3600000"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "449.07"

  Scenario Outline: Calculations from carrier, carrier region, zip code, carrier instance class, and duration
    Given it has "carrier.name" of "<carrier>"
    And it has "carrier_region.name" of "<carrier_region>"
    And it has "zip_code.name" of "<zip>"
    And it has "carrier_instance_class.name" of "<carrier_instance>"
    And it has "duration" of "3600000"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "<carbon>"
    Examples:
      | carrier | carrier_region    | zip   | carrier_instance | carbon |
      | Amazon  | Amazon us-east-1a |       | Amazon m1.large  | 320.55 |
      | Amazon  | Amazon us-east-1a | 94122 | Amazon m1.large  | 196.50 |
