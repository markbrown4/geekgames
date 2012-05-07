Feature: Gameplay
  Background:
    Given the games exist
  
  Scenario:
    Given A logged in user "Competitor"
      And I am on the games page
    When I follow "Start"
    Then I should see "Play now"