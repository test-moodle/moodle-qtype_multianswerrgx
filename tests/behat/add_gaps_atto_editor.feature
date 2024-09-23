@qtype @qtype_multianswerrgx
Feature: Test creating a Multianswerrgx (Cloze) question in Atto editor
  As a teacher
  In order to test my students
  I need to be able to try to create a Multianswerrgx (Cloze) question in Atto editor

  Background:
    Given the following "users" exist:
      | username |
      | teacher  |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user    | course | role           |
      | teacher | C1     | editingteacher |
    And the following config values are set as admin:
      | addclozegaps | 1 | qtype_multianswerrgx |
    And the following "user private files" exist:
      | user    | filepath                                  |
      | teacher | question/type/multianswerrgx/tests/fixtures/dick_s_cat.jpg |
    Given the following "user preferences" exist:
      | user    | preference | value |
      | teacher | htmleditor | atto  |

  @javascript
  Scenario: Try to create a Cloze question with the create gaps feature in Atto editor
    When I am on the "Course 1" "core_question > course question bank" page logged in as teacher
    And I press "Create a new question ..."
    And I set the field "Embedded answers with REGEXP (Clozergx)" to "1"
    And I click on "Add" "button" in the "Choose a question type to add" "dialogue"
    And I set the field "Question name" to "multianswer-01"
    And I should see "No cloze gaps?"
    And I should not see "Add close gaps"
    And I log out