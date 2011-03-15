Feature: Computation Emissions Calculations
  The computation model should generate correct emission calculations

  Scenario: Calculations starting from nothing
    Given a computation has nothing
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "0.07"

  Scenario Outline: Calculations from date
    Given a computation has "date" of "<date>"
    And it is the year "2010"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "<emission>"
    Examples:
      | date       | emission |
      | 2009-06-25 | 0.0      |
      | 2010-06-25 | 0.07     |
      | 2011-06-25 | 0.0      |

  Scenario Outline: Calculations from date and timeframe
    Given a computation has "date" of "<date>"
    And it has "timeframe" of "<timeframe>"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "<emission>"
    Examples:
      | date       | timeframe             | emission |
      | 2009-06-25 | 2009-01-01/2009-01-31 | 0.0      |
      | 2009-06-25 | 2009-01-01/2009-12-31 | 0.07     |
      | 2009-06-25 | 2009-12-01/2009-12-31 | 0.0      |

  Scenario: Calculations starting from duration
    Given a computation has "duration" of "36000"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "0.67"

  Scenario: Calculations starting from carrier instance class
    Given a computation has "carrier_instance_class.name" of "Amazon m1.large"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "0.27"

  Scenario: Calculations starting from carrier
    Given a computation has "carrier.name" of "Amazon"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "0.07"

  Scenario: Calculations starting from carrier
    Given a computation has "carrier_region.name" of "Amazon us-east-1a"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "0.08"

  Scenario: Calculations starting from zip code
    Given a computation has "zip_code.name" of "94122"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "0.05"

  Scenario: Calculations starting from electricity intensity and power usage effectiveness
    Given a computation has "electricity_intensity" of "0.5"
    And it has "power_usage_effectiveness" of "2.0"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "0.45"

  Scenario: Calculations starting from carrier, carrier region, and carrier instance class
    Given a computation has "carrier.name" of "Amazon"
    And it has "carrier_region.name" of "Amazon us-east-1a"
    And it has "carrier_instance_class.name" of "Amazon m1.large"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "0.32"

  Scenario: Calculations starting from carrier, carrier region, zip code, and carrier instance class
    Given a computation has "carrier.name" of "Amazon"
    And it has "carrier_region.name" of "Amazon us-east-1a"
    And it has "carrier_region.name" of "Amazon us-east-1a"
    And it has "zip_code.name" of "94122"
    And it has "carrier_instance_class.name" of "Amazon m1.large"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "0.19"

  Scenario: Calculations starting from duration, carrier, carrier region, zip code, and carrier instance class
    Given a computation has "duration" of "36000"
    And it has "carrier.name" of "Amazon"
    And it has "carrier_region.name" of "Amazon us-east-1a"
    And it has "carrier_region.name" of "Amazon us-east-1a"
    And it has "zip_code.name" of "94122"
    And it has "carrier_instance_class.name" of "Amazon m1.large"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "1.90"
