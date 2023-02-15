Feature: arrangement

  Scenario: one element
    Given the following data:
      | 0 |
    Then the full arrangement should:
    """
    : [
      [0]
    ]
    """

  Scenario: two elements
    Given the following data:
      | 0 | 1 |
    Then the full arrangement should:
    """
    : [
      [0 1]
      [1 0]
    ]
    """

  Scenario: two elements
    Given the following data:
      | 0 | 1 | 2 |
    Then the full arrangement should:
    """
    : [
      [0 1 2]
      [0 2 1]
      [1 0 2]
      [1 2 0]
      [2 0 1]
      [2 1 0]
    ]
    """
