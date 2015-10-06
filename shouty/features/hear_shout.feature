Feature: Hear Shout

  In order to find out whats going on locally
  As a shouty subscriber
  I want to hear shouts in my area

  Business Rules:
    - Range is 50m

  Background:
    Given the following subscribers:
      |name|location|
      |Sean|0|
      |Lucy|15|
      |Fred|60|

  Scenario: Listener is within range
    When Sean shouts "Free Bagels!"
    Then Lucy hears Sean's message

  Scenario: Listener hears a different message
    When Sean shouts "Free Coffee!"
    Then Lucy hears Sean's message

  Scenario: Listener is not within range
    When Sean shouts "Free Sausages!"
    Then Fred does not hear Sean's message
