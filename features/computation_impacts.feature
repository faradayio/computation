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
      | 2010-06-25 | 66.86    |
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
      | 2009-01-01/2009-12-31 | 66.86    |
      | 2009-12-01/2009-12-31 |  0.0     |

  Scenario: Calculations from carrier instance class and duration
    Given it has "carrier_instance_class.name" of "Amazon m1.large"
    And it has "duration" of "3600000"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "267.44"

  Scenario: Calculations from carrier and duration
    Given it has "carrier.name" of "Amazon"
    And it has "duration" of "3600000"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "66.86"

  Scenario: Calculations from carrier region and duration
    Given it has "carrier_region.name" of "Amazon us-east-1a"
    And it has "duration" of "3600000"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "80.31"

  Scenario: Calculations from zip code and duration
    Given it has "zip_code.name" of "94122"
    And it has "duration" of "3600000"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "47.57"

  Scenario: Calculations from electricity intensity, power usage effectiveness, and duration
    Given it has "electricity_intensity" of "0.5"
    And it has "power_usage_effectiveness" of "2.0"
    And it has "duration" of "3600000"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "445.73"

  Scenario: Calculations from carrier, carrier region, carrier instance class, and duration
    Given it has "carrier.name" of "Amazon"
    And it has "carrier_region.name" of "Amazon us-east-1a"
    And it has "carrier_instance_class.name" of "Amazon m1.large"
    And it has "duration" of "3600000"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "321.26"

  Scenario: Calculations from duration, carrier, carrier region, zip code, and carrier instance class
    Given it has "duration" of "3600000"
    And it has "carrier.name" of "Amazon"
    And it has "carrier_region.name" of "Amazon us-east-1a"
    And it has "carrier_region.name" of "Amazon us-east-1a"
    And it has "zip_code.name" of "94122"
    And it has "carrier_instance_class.name" of "Amazon m1.large"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.01" of "190.29"
