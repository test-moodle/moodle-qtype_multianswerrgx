@qtype @qtype_multianswerrgx @editor_tiny
Feature: Test duplicating a quiz containing multianswerrgx question
  As a teacher
  In order to re-use my courses containing multianswerrgx questions
  I need to be able to backup and restore them

  Background:
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "question categories" exist:
      | contextlevel | reference | name           |
      | Course       | C1        | Test questions |
    And the following "questions" exist:
      | questioncategory | qtype         | name                | template   |
      | Test questions   | multianswerrgx | multianswerrgx-001 | twosubq |
    And the following "activities" exist:
      | activity   | name      | course | idnumber |
      | quiz       | Test quiz | C1     | quiz1    |
    And the following config values are set as admin:
      | enableasyncbackup | 0 |

  @javascript
  Scenario: Backup and restore a course containing a multianswerrgx question
    When I am on the "Course 1" course page logged in as admin
    And I backup "Course 1" course using this options:
      | Confirmation | Filename | test_backup.mbz |
    And I restore "test_backup.mbz" backup into a new course using this options:
      | Schema | Course name       | Course 2 |
      | Schema | Course short name | C2       |
    And I am on the "Course 2" "core_question > course question bank" page
    And I choose "Edit question" action for "multianswerrgx-001" in the question bank
    And I wait "3" seconds
    Then the following fields match these values:
      | Question name                      | multianswerrgx-001                   |
      | General feedback                   | <p>General feedback: It's from "The Owl and the Pussy-cat" by Lear: "The owl and the pussycat went to sea"</p>  |
    # @editor_tiny tag is needed for this to work; this avoids problems with the contents of Question text colliding with tiny_clozergx plugin.
    And I click on the "View > Source code" menu item for the "Question text" TinyMCE editor
    Then I should see "<p>Complete this opening line of verse: \"The {1:SHORTANSWER:Dog#Wrong,\n  silly!~=Owl#Well done!~*#Wrong answer} and the {1:MULTICHOICE:Bow-wow#You seem\n  to have a dog obsessions!~Wiggly worm#Now you are just being\n  ridiculous!~=Pussy-cat#Well done!} went to sea\".</p>" source code for the "Question text" TinyMCE editor
