@register
Feature: User Registration API

  Background:
    * url 'https://api.eventhub.rahulshettyacademy.com'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

  Scenario: Successful registration with valid credentials
    Given path '/api/auth/register'
    And request { email: 'student@example.com', password: 'secret123' }
    When method POST
    Then status 200
    And match response contains { message: '#string' }

  Scenario: Registration fails with duplicate email
    Given path '/api/auth/register'
    And request { email: 'student@example.com', password: 'secret123' }
    When method POST
    Then status 409
    And match response contains { message: '#string' }

  Scenario: Registration fails with missing email
    Given path '/api/auth/register'
    And request { password: 'secret123' }
    When method POST
    Then status 400
    And match response contains { message: '#string' }

  Scenario: Registration fails with missing password
    Given path '/api/auth/register'
    And request { email: 'student@example.com' }
    When method POST
    Then status 400
    And match response contains { message: '#string' }