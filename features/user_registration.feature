Feature: Authentication

  Scenario:
    Given A logged out user
      And I am on the home page
    When I follow "Compete"
    Then I should see "Sign in"

  Scenario:
    Given A logged in user "Competitor"
      And I am on the games page
    When I follow "Start"
    Then I should see "Play now"