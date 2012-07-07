Feature: Accurate Leaderboard
  Leaderboard should show top users for today, all time and the leading country
  
  Scenario:
    Given these rounds
      | username    | country | score1  | score2  | score3  | date         |
      | Lucky Lukey | AU      | 50      | 50      | 50      | |
      | markbrown4  | AU      | 50      | 50      | 50      | |
      | MaoZedong   | CN      | 50      | 50      | 51      | |
      | LiuBei      | CN      | 50      | 50      | 48      | |
      | Jesus       | IL      | 50      | 50      | 52      | '0001-01-01' |
      | Barabbus    | IL      | 1       | 1       | 1       | '0001-01-01' |
    When I am on the leaderboard page
     And I should see "Jesus" within first place
     And I should see "152" within first place
     And I should see "Australia" within first placed country
     And I should see "China" within second placed country
