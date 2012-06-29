Feature: Authentication
  Allow logged in users to compete
  Allow users to edit profile

  Scenario:
    Given A logged out user
      And I am on the home page
    When I follow "Compete"
    Then I should see "Sign in"

  Scenario:
    Given A logged in user "Competitor"
      And I am on the profile page
    When I fill in "Username" with "MaoZedong"
     And I press "Update"
    Then I should see "MaoZedong" within the user drop down

  Scenario: Signing Up via Facebook
    Given I am on the home page
      And I follow "Play"
      And I follow "Sign up via Facebook"
    Then  I should be signed in