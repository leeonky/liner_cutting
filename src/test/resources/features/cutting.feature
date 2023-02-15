Feature: liner cutting

  Rule: no segments
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

  Rule: one segment
    Scenario: use whole input one size one count
      Given the following lines:
        | 100 | 1 |
      When need segments:
        | 100 | 1 |
      Then got following result:
      """
      resultContent= ```
                     100(1):
                     | 100 |
                     | 100 |
                     ```
      """

    Scenario: raise error when no more available input
      Given the following lines:
        | 50 | 1 |
      When need segments:
        | 100 | 1 |
      Then got following result:
      """
      resultContent::throw.message: 'Given input is not enough'
      """

    Scenario: choose the available input
      Given the following lines:
        | 50 | 1 |
        | 80 | 1 |
      When need segments:
        | 80 | 1 |
      Then got following result:
      """
      resultContent= ```
                     50(0):
                     | 50 |

                     80(1):
                     | 80 |
                     | 80 |
                     ```
      """

    Scenario: use short input first for last one segment
      Given the following lines:
        | 100 | 1 |
        | 50  | 1 |
      When need segments:
        | 10 | 1 |
      Then got following result:
      """
      resultContent= ```
                     50(1):
                     | 50 |
                     | 10 |

                     100(0):
                     | 100 |
                     ```
      """

  Rule: two segment
    Scenario: left more
      Given the following lines:
        | 100 | 1 |
        | 60  | 1 |
      When need segments:
        | 50 | 1 |
        | 40 | 1 |
      Then got following result:
      """
      resultContent= ```
                     100(2):
                     | 100 |
                     | 50 | 40 |

                     60(0):
                     | 60 |
                     ```
      """
