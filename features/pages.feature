Feature: CMS for pages
  Pages should load by slugs and display the title & content

  Scenario:
    Given a "privacy" page exists with title "Privacy Policy"
    When I am on the "privacy" page
    Then I should see "Privacy Policy" within "h1"
