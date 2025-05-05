# Mini OS Project - README

## Overview

This project simulates a simple operating system (Mini OS) using **Java** and **Assembly** (MIPS Assembly language in a different part of the project). The OS includes various modules, such as user authentication (login/registration), a calculator, a counter with speed and limit settings, a number guessing game, and a unit converter. It offers a text-based interface to interact with users and perform the tasks.

## Modules

### 1. Authentication (Login/Register)

- **Registration**: Users can create an account by entering a username and a national ID number. The ID is incremented by 1 when creating an account.
- **Login**: Users can log in using their unique User ID, which is validated against the saved ID from the registration process.

### 2. Calculator

- Supports different number types: `int`, `float`, and `double`.
- Basic arithmetic operations: addition (+), subtraction (-), multiplication (*), and division (/).
- The user can choose to continue on the result or exit the calculator.

### 3. Counter Module

- A simple counter that allows the user to:
  - Set a count limit.
  - Adjust the counting speed (Slow, Normal, Fast).
  - Start the counter, which counts up to the limit set, with delays based on the chosen speed.

### 4. Guess the Number Game

- The system generates a random number between 1 and 100, and the user must guess the number.
- The system provides feedback if the guess is too high or too low until the correct number is guessed.

### 5. Unit Converter

- **Meter to Centimeter**: Converts meters to centimeters.
- **Kilogram to Gram**: Converts kilograms to grams.
- **Celsius to Fahrenheit**: Converts temperatures from Celsius to Fahrenheit.
- **Minutes to Seconds**: Converts minutes to seconds.

## Features

- **User Authentication**: Users can register and log in securely with their User ID.
- **Simple Arithmetic Calculator**: Supports multiple number types and basic operations.
- **Counter Module**: Lets the user control counting speed and limit.
- **Guessing Game**: Fun number guessing game with feedback for the user's guesses.
- **Unit Conversion**: Convert between common units like meters to centimeters, kilograms to grams, etc.
- **Multi-module Interface**: After successful login, users can select from multiple options using a menu-driven system.

## Project Structure

### Main Class: `MiniOS.java`

- This is the entry point to the project, which handles authentication (register/login) and displays the main menu for the available modules.
- It contains methods for the calculator, counter, guessing game, and unit conversion, as well as user input handling.

### Key Methods

- **authLoop()**: Handles the user authentication loop (registration and login).
- **register()**: Allows the user to create a new account by entering a username and national ID.
- **login()**: Validates user credentials and logs the user in.
- **menuLoop()**: Displays the main menu after the user successfully logs in.
- **calculator()**: Provides a simple arithmetic calculator with different number types.
- **counter()**: Allows the user to configure and use a counter with variable speed and limit settings.
- **guessTheNumber()**: A number guessing game where the user must guess a secret number.
- **unitConverter()**: Offers various unit conversion options, such as meters to centimeters, kilograms to grams, etc.

