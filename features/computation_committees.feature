Feature: Computation Committee Calculations
  The computation model should generate correct committee calculations

  Scenario: EC2 compute units committee from default
    Given a computation emitter
    When the "ec2_compute_units" committee is calculated
    Then the committee should have used quorum "default"
    And the conclusion of the committee should be "1"

  Scenario: Duration commitee from default
    Given a computation emitter
    When the "duration" committee is calculated
    Then the committee should have used quorum "default"
    And the conclusion of the committee should be "1.0"

  Scenario: eGRID subregion committee from default
    Given a computation emitter
    When the "egrid_subregion" committee is calculated
    Then the committee should have used quorum "default"
    And the conclusion of the committee should have "abbreviation" of "US"

  Scenario: eGRID subregion commitee from zip code
    Given a computation emitter
    And a characteristic "zip_code.name" of "94122"
    When the "egrid_subregion" committee is calculated
    Then the committee should have used quorum "from zip code"
    And the conclusion of the committee should have "abbreviation" of "CAMX"

  Scenario: eGRID region committee from default eGRID subregion
    Given a computation emitter
    When the "egrid_subregion" committee is calculated
    And the "egrid_region" committee is calculated
    Then the committee should have used quorum "from eGRID subregion"
    And the conclusion of the committee should have "name" of "US"

  Scenario: eGRID region committe from zip code
    Given a computation emitter
    And a characteristic "zip_code.name" of "94122"
    When the "egrid_subregion" committee is calculated
    And the "egrid_region" committee is calculated
    Then the committee should have used quorum "from eGRID subregion"
    And the conclusion of the committee should have "name" of "W"

  Scenario: Electricity intensity commtitee from default
    Given a computation emitter
    When the "electricity_intensity" committee is calculated
    Then the committee should have used quorum "default"
    And the conclusion of the committee should be "0.075"

  Scenario: Power usage effectiveness commtitee from default
    Given a computation emitter
    When the "power_usage_effectiveness" committee is calculated
    Then the committee should have used quorum "default"
    And the conclusion of the committee should be "1.5"

  Scenario: Electricity use commitee from default EC2 compute units, duration, electricity intensity, zip code, and PUE
    Given a computation emitter
    When the "ec2_compute_units" committee is calculated
    And the "duration" committee is calculated
    And the "egrid_subregion" committee is calculated
    And the "egrid_region" committee is calculated
    And the "electricity_intensity" committee is calculated
    And the "power_usage_effectiveness" committee is calculated
    And the "electricity_use" committee is calculated
    Then the committee should have used quorum "from compute units, time, electricity intensity, PUE, and eGRID region"
    And the conclusion of the committee should be "0.14063"

  Scenario: Electricity use commitee from EC2 compute units, duration, electricity intensity, zip code, and PUE
    Given a computation emitter
    And a characteristic "ec2_compute_units" of "10"
    And a characteristic "duration" of "10"
    And a characteristic "zip_code.name" of "94122"
    And a characteristic "electricity_intensity" of "1.0"
    And a characteristic "power_usage_effectiveness" of "2.0"
    And the "egrid_subregion" committee is calculated
    And the "egrid_region" committee is calculated
    And the "electricity_use" committee is calculated
    Then the committee should have used quorum "from compute units, time, electricity intensity, PUE, and eGRID region"
    And the conclusion of the committee should be "222.22222"

  Scenario: Emission factor committee from default eGRID subregion
    Given a computation emitter
    When the "egrid_subregion" committee is calculated
    And the "emission_factor" committee is calculated
    Then the committee should have used quorum "from eGRID subregion"
    And the conclusion of the committee should be "2.0"

  Scenario: Emission factor committee from zip code
    Given a computation emitter
    And a characteristic "zip_code.name" of "94122"
    When the "egrid_subregion" committee is calculated
    And the "emission_factor" committee is calculated
    Then the committee should have used quorum "from eGRID subregion"
    And the conclusion of the committee should be "1.0"
