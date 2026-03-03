@login
Feature: User Login API

  Background:
    * url 'https://api.eventhub.rahulshettyacademy.com'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

  Scenario: Successful login returns auth token
    Given path '/api/auth/login'
    And request { email: 'student@example.com', password: 'secret123' }
    When method POST
    Then status 200
    And match response contains { token: '#string' }
    * def authToken = response.token
    * print 'Auth Token:', authToken

  Scenario: Login fails with wrong password
    Given path '/api/auth/login'
    And request { email: 'student@example.com', password: 'wrongpassword' }
    When method POST
    Then status 401
    And match response contains { message: '#string' }

  Scenario: Login fails with unregistered email
    Given path '/api/auth/login'
    And request { email: 'ghost@example.com', password: 'secret123' }
    When method POST
    Then status 401
    And match response contains { message: '#string' }

  Scenario: Login fails with empty body
    Given path '/api/auth/login'
    And request {}
    When method POST
    Then status 400
    And match response contains { message: '#string' }