Feature: liner cutting
  Rule: no segments needed

    Scenario: one size one count
      Given the following lines:
        | 100 | 1 |
      Then got following result:
      """
      resultContent= ```
                     100(0):
                     | 100 |
                     ```
      """

    Scenario: one size many count
      Given the following lines:
        | 50 | 2 |
      Then got following result:
      """
      resultContent= ```
                     50(0):
                     | 50 |

                     50(0):
                     | 50 |
                     ```
      """

    Scenario: two size one count
      Given the following lines:
        | 100 | 1 |
        | 50  | 1 |
      Then got following result:
      """
      resultContent= ```
                     100(0):
                     | 100 |

                     50(0):
                     | 50 |
                     ```
      """

#  Scenario: one cutting with whole line
#    Given the following lines:
#      | 100 | 1 |
#    When need segments
#      | 100 | 1 |
#    Then got following result:
#    """
#    100:
#    | 100 |
#    | 100 |
#    """
