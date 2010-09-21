Feature: Computation Committee Calculations
  The computation model should generate correct committee calculations

  Scenario: Emission committee from default
    Given a computation emitter
    When the "emission" committee is calculated
    Then the committee should have used quorum "default"
    And the conclusion of the committee should be "100.0"
