Feature: Accurate Leaderboard
  Leaderboard should show top users for today, all time and the leading country

  Scenario:
    Given these rounds
      | username    | country   | score1  | score2  | score3  | date         |
      | Lucky Lukey | Australia | 50      | 50      | 50      | |
      | markbrown4  | Australia | 50      | 50      | 50      | |
      | MaoZedong   | China     | 50      | 50      | 51      | |
      | LiuBei      | China     | 50      | 50      | 48      | |
      | Jesus       | Israel    | 50      | 50      | 52      | '0001-01-01' |
      | Barabbus    | Israel    | 1       | 1       | 1       | '0001-01-01' |
    When I am on the leaderboard page
    Then I should see "MaoZedong" within todays first
     And I should see "Jesus" within all time first
     And I should see "152" within all time first
     And I should see "Australia" within first placed country
     And I should see "China" within second placed country
