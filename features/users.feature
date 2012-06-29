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
      And I should see "Confirm your email"
      And my email should be filled in

    When  I check "Receive Cool tech deals from SitePoint & carefully selected 3rd-party partners."
      And I press "Submit"
    Then  I should see "The 10cm Dash"

  Scenario: Signing Up via Twitter
    Given I am on the home page
      And I follow "Play"
      And I follow "Sign up via Twitter"
    Then  I should be signed in
      And I should see "Confirm your email"
      And the "Email" field should be empty

    When  I fill in "Email" with "mark@inspire9.com"
      And I check "Receive Cool tech deals from SitePoint & carefully selected 3rd-party partners."
      And I press "Submit"
    Then  I should see "The 10cm Dash"