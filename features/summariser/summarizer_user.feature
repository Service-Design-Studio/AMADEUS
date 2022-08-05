@user @summariser_user
Feature: Read article summary
  As a user of AMADEUS
  So that I can easily comprehend a new article
  I want to be able to read its summary

  Background:
    Given I am a user of AMADEUS
    And the following zip files have been uploaded: rus.zip

  @happy
  Scenario Outline: Viewing summary when browsing articles in the 'Home' page
    Given I am on the "Home" page
    Then I should see the summary "<summary>" belongs to the article "<article_name>"

    Examples:
      | article_name                                                              | summary                                                                                                                                                                                                                                                                                                                               |
      | Russia's economy in for a bumpy ride as sanctions bite - BBC News         | Russia is now the most sanctionedcountry in the world. More than 10,500restrictions have been imposed on Russian individuals and companies. In 2022 the Russian economy isexpected to shrink by up to 10%. Russian consumers are yet to feel the full e ects.                                                                         |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News | Marc Fogel had around 17g (0.6oz) of cannabis in his luggagewhen he was caught on 15 August 2021 at Sheremetyevo airport. Fogel was sentenced in the same jurisdiction that is hearing a marijuana-related case against US basketball star Brittney Griner. Cannabis is legal in many parts of the US, but remains illegal in Russia. |

  @happy
  Scenario Outline: Viewing corresponding summary when viewing the article
    Given I am viewing the article "<article_name>"
    Then I should see the summary "<summary>".

    Examples:
      | article_name                                                              | summary                                                                                                                                                                                                                                                                                                                               |
      | Russia's economy in for a bumpy ride as sanctions bite - BBC News         | Russia is now the most sanctionedcountry in the world. More than 10,500restrictions have been imposed on Russian individuals and companies. In 2022 the Russian economy isexpected to shrink by up to 10%. Russian consumers are yet to feel the full e ects.                                                                         |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News | Marc Fogel had around 17g (0.6oz) of cannabis in his luggagewhen he was caught on 15 August 2021 at Sheremetyevo airport. Fogel was sentenced in the same jurisdiction that is hearing a marijuana-related case against US basketball star Brittney Griner. Cannabis is legal in many parts of the US, but remains illegal in Russia. |
