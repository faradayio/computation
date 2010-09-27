Feature: Computation Emissions Calculations
  The computation model should generate correct emission calculations

  Scenario: Calculations starting from nothing
    Given a computation has nothing
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "0.28"

  Scenario: Calculations starting from compute units
    Given a computation has "compute_units" of "10"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "2.81"

  Scenario: Calculations starting from compute time
    Given a computation has "compute_time" of "10"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "2.81"

  Scenario: Calculations starting from zip code
    Given a computation has "zip_code.name" of "94122"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "0.13"

  Scenario: Calculations starting from compute electricity intensity
    Given a computation has "compute_electricity_intensity" of "1.0"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "3.75"

    Scenario: Calculations starting from power usage effectiveness
      Given a computation has "power_usage_effectiveness" of "2.0"
      When emissions are calculated
      Then the emission value should be within "0.01" kgs of "0.38"

  Scenario: Calculations starting from compute units, time, electricity intensity, zip code, and PUE
    Given a computation has "compute_units" of "10"
    And it has "compute_time" of "10"
    And it has "zip_code.name" of "94122"
    And it has "compute_electricity_intensity" of "1.0"
    And it has "power_usage_effectiveness" of "2.0"
    When emissions are calculated
    Then the emission value should be within "0.01" kgs of "222.22"
