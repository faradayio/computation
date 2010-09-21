Feature: Computation Emissions Calculations
  The computation model should generate correct emission calculations

  Scenario: Calculations starting from nothing
    Given a computation has nothing
    When emissions are calculated
    Then the emission value should be within "0.1" kgs of "100.0"
