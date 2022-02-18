Feature: RFC 0454 Aries agent present proof

   @T001-RFC0454 @GHA
   Scenario Outline: Present Proof where the prover does not propose a presentation of the proof and is acknowledged
      Given we have "2" agents
         | name  | role     | capabilities        |
         | Donance | verifier | <UniWest_capabilities> |
         | Bob   | prover   | <Bob_capabilities>  |
      And "<issuer>" and "Bob" have an existing connection
      And "Bob" has an issued <Schema_name> credential <Credential_data> from "<issuer>"
      And "Donance" and "Bob" have an existing connection
      When "Donance" sends a request for proof presentation <Proof_request> to "Bob"
      Then "Donance" has the proof verified

      Examples:
         | issuer | UniWest_capabilities                      | Bob_capabilities          | Schema_name       | Credential_data   | Proof_request     |
         | Donance  | --public-did                           |                           | driverslicense_v2 | Data_DL_MaxValues | DL_age_over_19_v2 |
         | Donance  | --public-did --did-exchange            | --did-exchange            | driverslicense_v2 | Data_DL_MaxValues | DL_age_over_19_v2 |


   @T001.1-RFC0454
   Scenario Outline: Present Proof where the prover does not propose a presentation of the proof and is acknowledged
      Given we have "3" agents
         | name  | role     | capabilities        |
         | UniWest  | issuer   | <UniWest_capabilities> |
         | Donance | verifier | <UniWest_capabilities> |
         | Bob   | prover   | <Bob_capabilities>  |
      And "<issuer>" and "Bob" have an existing connection
      And "Bob" has an issued <Schema_name> credential <Credential_data> from "<issuer>"
      And "Donance" and "Bob" have an existing connection
      When "Donance" sends a request for proof presentation <Proof_request> to "Bob"
      Then "Donance" has the proof verified

      Examples:
         | issuer | UniWest_capabilities                      | Bob_capabilities          | Schema_name       | Credential_data   | Proof_request     |
         | UniWest   | --public-did                           |                           | driverslicense_v2 | Data_DL_MaxValues | DL_age_over_19_v2 |
         | Donance  | --public-did                           |                           | driverslicense_v2 | Data_DL_MaxValues | DL_age_over_19_v2 |
         | UniWest   | --public-did --mediation --multitenant | --mediation --multitenant | driverslicense_v2 | Data_DL_MaxValues | DL_age_over_19_v2 |


   @T001.2-RFC0454 @GHA
   Scenario Outline: Present Proof json-ld where the prover does not propose a presentation of the proof and is acknowledged
      Given we have "2" agents
         | name  | role     | capabilities        |
         | UniWest  | issuer   | <UniWest_capabilities> |
         | Donance | verifier | <UniWest_capabilities> |
         | Bob   | prover   | <Bob_capabilities>  |
      And "<issuer>" and "Bob" have an existing connection
      And "Bob" has an issued json-ld <Schema_name> credential <Credential_data> from "<issuer>"
      And "Donance" and "Bob" have an existing connection
      When "Donance" sends a request for json-ld proof presentation <Proof_request> to "Bob"
      Then "Donance" has the proof verified

      Examples:
         | issuer | UniWest_capabilities                                         | Bob_capabilities          | Schema_name       | Credential_data   | Proof_request     |
         | UniWest   | --public-did --cred-type json-ld                          |                           | driverslicense_v2 | Data_DL_MaxValues | DL_age_over_19_v2 |
         | Donance  | --public-did --cred-type json-ld --did-exchange           | --did-exchange            | driverslicense_v2 | Data_DL_MaxValues | DL_age_over_19_v2 |


   @T002-RFC0454 @GHA
   Scenario Outline: Present Proof where the issuer revokes the credential and the proof fails
      Given we have "2" agents
         | name  | role     | capabilities        |
         | Donance | verifier | <UniWest_capabilities> |
         | Bob   | prover   | <Bob_capabilities>  |
      And "<issuer>" and "Bob" have an existing connection
      And "Bob" has an issued <Schema_name> credential <Credential_data> from "<issuer>"
      And "<issuer>" revokes the credential
      And "Donance" and "Bob" have an existing connection
      When "Donance" sends a request for proof presentation <Proof_request> to "Bob"
      Then "Donance" has the proof verification fail

      Examples:
         | issuer | UniWest_capabilities                          | Bob_capabilities | Schema_name       | Credential_data   | Proof_request     |
         | Donance  | --revocation --public-did                  |                  | driverslicense_v2 | Data_DL_MaxValues | DL_age_over_19_v2 |
         | Donance  | --revocation --public-did --did-exchange   | --did-exchange   | driverslicense_v2 | Data_DL_MaxValues | DL_age_over_19_v2 |


   @T002.1-RFC0454
   Scenario Outline: Present Proof where the issuer revokes the credential and the proof fails
      Given we have "3" agents
         | name  | role     | capabilities        |
         | UniWest  | issuer   | <UniWest_capabilities> |
         | Donance | verifier | <UniWest_capabilities> |
         | Bob   | prover   | <Bob_capabilities>  |
      And "<issuer>" and "Bob" have an existing connection
      And "Bob" has an issued <Schema_name> credential <Credential_data> from "<issuer>"
      And "<issuer>" revokes the credential
      And "Donance" and "Bob" have an existing connection
      When "Donance" sends a request for proof presentation <Proof_request> to "Bob"
      Then "Donance" has the proof verification fail

      Examples:
         | issuer | UniWest_capabilities                          | Bob_capabilities | Schema_name       | Credential_data   | Proof_request     |
         | UniWest   | --revocation --public-did                  |                  | driverslicense_v2 | Data_DL_MaxValues | DL_age_over_19_v2 |
         | Donance  | --revocation --public-did                  |                  | driverslicense_v2 | Data_DL_MaxValues | DL_age_over_19_v2 |
         | UniWest   | --revocation --public-did --mediation      |                  | driverslicense_v2 | Data_DL_MaxValues | DL_age_over_19_v2 |
         | UniWest   | --revocation --public-did --multitenant    | --multitenant    | driverslicense_v2 | Data_DL_MaxValues | DL_age_over_19_v2 |
