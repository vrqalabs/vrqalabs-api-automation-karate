@me
Feature: Get Authenticated User Profile API

  Background:
    * url 'https://api.eventhub.rahulshettyacademy.com'
    * header Accept = 'application/json'

    # Login first to get a valid token
    * def loginResult = call read('login.feature@login')
    * def authToken = loginResult.response.token

  Scenario: Successfully fetch profile with valid token
    Given path '/api/auth/me'
    And header Authorization = 'Bearer ' + authToken
    When method GET
    Then status 200
    And match response contains { email: '#string' }
    And match response.email == 'student@example.com'

  Scenario: Fetch profile fails without token
    Given path '/api/auth/me'
    When method GET
    Then status 401
    And match response contains { message: '#string' }

  Scenario: Fetch profile fails with invalid token
    Given path '/api/auth/me'
    And header Authorization = 'Bearer invalidtoken123'
    When method GET
    Then status 401
    And match response contains { message: '#string' }