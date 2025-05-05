import java.util.Scanner;
import java.util.Random;

public class MiniOS {
    // Data storage
    private static String savedUsername = "";
    private static int savedId = -1;
    
    // Counter module variables
    private static int counterLimit = 10;
    private static int counterSpeed = 2; // 1: Slow, 2: Normal, 3: Fast
    
    // Scanner for user input
    private static Scanner scanner = new Scanner(System.in);
    private static Random random = new Random();
    
    public static void main(String[] args) {
        authLoop();
    }
    
    // Authentication loop
    private static void authLoop() {
        while (true) {
            System.out.println("\n===== Welcome to Mini OS =====");
            System.out.println("1. Register");
            System.out.println("2. Login");
            System.out.print("Choose an option: ");
            
            int choice = scanner.nextInt();
            scanner.nextLine(); // Consume newline
            
            switch (choice) {
                case 1:
                    register();
                    break;
                case 2:
                    if (login()) {
                        menuLoop();
                    }
                    break;
                default:
                    continue;
            }
        }
    }
    
    // Registration
    private static void register() {
        System.out.print("Enter username: ");
        savedUsername = scanner.nextLine();
        
        System.out.print("Enter your national ID number: ");
        savedId = scanner.nextInt();
        scanner.nextLine(); // Consume newline
        
        // Generate user ID (just increment the national ID for this example)
        savedId += 1;
        
        System.out.println("\nAccount created successfully! Your User ID: " + savedId);
    }
    
    // Login
    private static boolean login() {
        System.out.print("Enter your user ID: ");
        int inputId = scanner.nextInt();
        scanner.nextLine(); // Consume newline
        
        if (inputId == savedId) {
            System.out.println("\nLogin successful!");
            return true;
        } else {
            System.out.println("\nInvalid ID entered! Try again.");
            return false;
        }
    }
    
    // Main menu loop
    private static void menuLoop() {
        while (true) {
            System.out.println("\n====== Mini OS Simulator ======");
            System.out.println("1. Calculator");
            System.out.println("2. Counter");
            System.out.println("3. Guess the Number");
            System.out.println("4. Unit Converter");
            System.out.println("5. Exit");
            System.out.print("Choose an option: ");
            
            int choice = scanner.nextInt();
            scanner.nextLine(); // Consume newline
            
            switch (choice) {
                case 1:
                    calculator();
                    break;
                case 2:
                    counter();
                    break;
                case 3:
                    guessTheNumber();
                    break;
                case 4:
                    unitConverter();
                    break;
                case 5:
                    System.out.println("\n[Exiting Mini OS... Goodbye!]");
                    System.exit(0);
                default:
                    System.out.println("Invalid choice. Try again.");
            }
        }
    }
    
    // Calculator
    private static void calculator() {
        int type = 0; // 0 = int, 1 = float, 2 = double
        boolean continueWithResult = false;
        double result = 0;
        
        while (true) {
            if (!continueWithResult) {
                System.out.print("\nEnter number type (i=int, f=float, d=double): ");
                char typeChar = scanner.next().charAt(0);
                
                switch (typeChar) {
                    case 'i':
                        type = 0;
                        break;
                    case 'f':
                        type = 1;
                        break;
                    case 'd':
                        type = 2;
                        break;
                    default:
                        System.out.println("Invalid input!");
                        continue;
                }
                
                System.out.print("Enter number: ");
                result = readNumber(type);
            }
            
            System.out.print("Enter operation (+, -, *, /): ");
            char op = scanner.next().charAt(0);
            
            System.out.print("Enter number: ");
            double num2 = readNumber(type);
            
            // Perform calculation
            switch (op) {
                case '+':
                    result += num2;
                    break;
                case '-':
                    result -= num2;
                    break;
                case '*':
                    result *= num2;
                    break;
                case '/':
                    if (num2 == 0) {
                        System.out.println("Error: Division by zero!");
                        continue;
                    }
                    result /= num2;
                    break;
                default:
                    System.out.println("Invalid operator!");
                    continue;
            }
            
            // Print result
            System.out.print("Result: ");
            printNumber(result, type);
            
            // Ask to continue
            System.out.print("\nContinue on result? (y/n): ");
            char cont = scanner.next().charAt(0);
            
            if (cont == 'y') {
                continueWithResult = true;
            } else {
                return;
            }
        }
    }
    
    private static double readNumber(int type) {
        switch (type) {
            case 0: // int
                return scanner.nextInt();
            case 1: // float
                return scanner.nextFloat();
            case 2: // double
                return scanner.nextDouble();
            default:
                return 0;
        }
    }
    
    private static void printNumber(double value, int type) {
        switch (type) {
            case 0: // int
                System.out.print((int)value);
                break;
            case 1: // float
                System.out.print((float)value);
                break;
            case 2: // double
                System.out.print(value);
                break;
        }
    }
    
    // Counter module
    private static void counter() {
        // Ask for password (default is 1234)
        System.out.print("Enter password: ");
        int password = scanner.nextInt();
        scanner.nextLine(); // Consume newline
        
        if (password != 1234) {
            System.out.println("\nIncorrect password. Returning to menu...");
            return;
        }
        
        while (true) {
            System.out.println("\n--- Counter Menu ---");
            System.out.println("1. Set Limit");
            System.out.println("2. Set Speed");
            System.out.println("3. Start Counter");
            System.out.println("4. Back");
            System.out.print("Choose: ");
            
            int choice = scanner.nextInt();
            scanner.nextLine(); // Consume newline
            
            switch (choice) {
                case 1:
                    System.out.print("Enter limit (max count): ");
                    counterLimit = scanner.nextInt();
                    scanner.nextLine(); // Consume newline
                    break;
                case 2:
                    System.out.print("Choose speed (1: Slow, 2: Normal, 3: Fast): ");
                    counterSpeed = scanner.nextInt();
                    scanner.nextLine(); // Consume newline
                    break;
                case 3:
                    startCounter();
                    break;
                case 4:
                    return;
                default:
                    System.out.println("Invalid choice!");
            }
        }
    }
    
    private static void startCounter() {
        System.out.println("\nStarting counter...");
        
        for (int i = 1; i <= counterLimit; i++) {
            System.out.println(i);
            delay();
        }
    }
    
    private static void delay() {
        long delayTime;
        
        switch (counterSpeed) {
            case 1: // Slow
                delayTime = 2000;
                break;
            case 2: // Normal
                delayTime = 1000;
                break;
            case 3: // Fast
                delayTime = 500;
                break;
            default:
                delayTime = 1000;
        }
        
        try {
            Thread.sleep(delayTime);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
    
    // Guess the Number game
    private static void guessTheNumber() {
        int secretNumber = random.nextInt(100) + 1;
        System.out.println("\nGuess the number between 1 and 100:");
        
        while (true) {
            int guess = scanner.nextInt();
            scanner.nextLine(); // Consume newline
            
            if (guess == secretNumber) {
                System.out.println("Correct!");
                return;
            } else if (guess > secretNumber) {
                System.out.println("Too high! Try again:");
            } else {
                System.out.println("Too low! Try again:");
            }
        }
    }
    
    // Unit Converter
    private static void unitConverter() {
        while (true) {
            System.out.println("\n===== Unit Converter =====");
            System.out.println("1. Meter to Centimeter");
            System.out.println("2. Kilogram to Gram");
            System.out.println("3. Celsius to Fahrenheit");
            System.out.println("4. Minutes to Seconds");
            System.out.println("5. Go back to Menu");
            System.out.print("Choose an option: ");
            
            int choice = scanner.nextInt();
            scanner.nextLine(); // Consume newline
            
            switch (choice) {
                case 1:
                    meterToCentimeter();
                    break;
                case 2:
                    kilogramToGram();
                    break;
                case 3:
                    celsiusToFahrenheit();
                    break;
                case 4:
                    minutesToSeconds();
                    break;
                case 5:
                    return;
                default:
                    System.out.println("Invalid choice!");
            }
        }
    }
    
    private static void meterToCentimeter() {
        System.out.print("Enter the number: ");
        double meters = scanner.nextDouble();
        scanner.nextLine(); // Consume newline
        double centimeters = meters * 100;
        System.out.println("Result: " + centimeters);
    }
    
    private static void kilogramToGram() {
        System.out.print("Enter the number: ");
        double kilograms = scanner.nextDouble();
        scanner.nextLine(); // Consume newline
        double grams = kilograms * 1000;
        System.out.println("Result: " + grams);
    }
    
    private static void celsiusToFahrenheit() {
        System.out.print("Enter the number: ");
        double celsius = scanner.nextDouble();
        scanner.nextLine(); // Consume newline
        double fahrenheit = (celsius * 9/5) + 32;
        System.out.println("Result: " + fahrenheit);
    }
    
    private static void minutesToSeconds() {
        System.out.print("Enter the number: ");
        double minutes = scanner.nextDouble();
        scanner.nextLine(); // Consume newline
        double seconds = minutes * 60;
        System.out.println("Result: " + seconds);
    }
}