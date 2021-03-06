Feature: RFC 0160 Aries agent connection functions

   @T001-RFC0160 @GHA
   Scenario Outline: establish a connection between two agents
      Given we have "2" agents
         | name  | role    | capabilities        |
         | UniWest  | inviter | <UniWest_capabilities> |
         | Bob   | invitee | <Bob_capabilities>  |
      When "UniWest" generates a connection invitation
      And "Bob" receives the connection invitation
      Then "UniWest" has an active connection
      And "Bob" has an active connection

      Examples:
         | UniWest_capabilities                      | Bob_capabilities          |
         | --public-did                           |                           |
         | --public-did --did-exchange            | --did-exchange            |
         | --public-did --mediation               | --mediation               |
         | --public-did --multitenant             | --multitenant             |
         | --public-did --mediation --multitenant | --mediation --multitenant |
