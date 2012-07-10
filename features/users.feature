Feature: Authentication
  Allow logged in users to compete
  Allow users to edit profile

  Scenario:
    Given A logged out user
      And I am on the home page
    When I follow "Play"
    Then I should see "Sign in"

  Scenario: Signing Up via Facebook
    Given I am on the home page
      And I follow "Play"
      And I follow "Sign in via Facebook"
    Then  I should be signed in
      And I should see "Confirm your details"
      And my email should be filled in
     When I fill in "Username" with "markymark"
     When I select "Australia" from "Country"
      And I check "Receive Cool tech deals from SitePoint & carefully selected 3rd-party partners."
      And I press "Submit"
    Then  I should see "The 10cm Dash"

  Scenario: Signing Up via Twitter
    Given I am on the home page
      And I follow "Play"
      And I follow "Sign in via Twitter"
    Then  I should be signed in
      And I should see "Confirm your details"
      And the "Email" field should be empty

    When  I fill in "Email" with "mark@inspire9.com"
      And I fill in "Username" with "markymark"
      And I select "Australia" from "Country"
      And I check "Receive Cool tech deals from SitePoint & carefully selected 3rd-party partners."
      And I press "Submit"
    Then  I should see "The 10cm Dash"