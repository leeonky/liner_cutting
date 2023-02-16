Feature: liner cutting

  Rule: no segments
    Scenario: one size one count
      Given the following lines:
        | 100 | 1 |
      Then got following result:
      """
      resultContent= ```
                     100(0) 100:
                     | 100 |
                     ```
      """

    Scenario: one size many count
      Given the following lines:
        | 50 | 2 |
      Then got following result:
      """
      resultContent= ```
                     50(0) 50:
                     | 50 |

                     50(0) 50:
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
                     100(0) 100:
                     | 100 |

                     50(0) 50:
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
                     100(1) 0:
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
                     80(1) 0:
                     | 80 |
                     | 80 |

                     50(0) 50:
                     | 50 |
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
                     100(0) 100:
                     | 100 |

                     50(1) 40:
                     | 50 |
                     | 10 |
                     ```
      """

  Rule: two segment
    Scenario: left more
      Given the following lines:
        | 95 | 1 |
        | 60 | 1 |
      When need segments:
        | 50 | 1 |
        | 40 | 1 |
      Then got following result:
      """
      resultContent= ```
                     95(2) 5:
                     | 95 |
                     | 50 | 40 |

                     60(0) 60:
                     | 60 |
                     ```
      """

    Scenario: xxx
      Given the following lines:
#        | 243  | 2 |
        | 300  | 1 |
#        | 260  | 1 |
        | 570  | 1 |
        | 480  | 1 |
        | 355  | 1 |
        | 795  | 1 |
        | 765  | 1 |
        | 650  | 1 |
        | 665  | 1 |
        | 1527 | 1 |
        | 1505 | 1 |
        | 1610 | 1 |
        | 1560 | 1 |
        | 1568 | 1 |
        | 1555 | 1 |

        | 1615 | 3 |
        | 850  | 1 |

      When need segments:
        | 722 | 2 |
#        | 260 | 1 |
        | 260 | 1 |
        | 204 | 2 |
#        | 204 | 2 |
        | 290 | 2 |
        | 693 | 2 |
        | 824 | 4 |
        | 824 | 4 |
        | 253 | 8 |
        | 956 | 2 |
        | 313 | 3 |
      Then got following result:
      """
      resultContent= ```
                     ```
      """
