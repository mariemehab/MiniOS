.data
# Welcome and Authentication


welcome:     .asciiz "\n===== Welcome to Mini OS =====\n1. Register\n2. Login\nChoose an option: "
username_msg: .asciiz "Enter username: "
id_prompt: .asciiz "Enter your national ID number: "
success_msg: .asciiz "\nAccount created successfully! Your User ID: "
login_prompt: .asciiz "Enter your user ID: "
login_success_msg: .asciiz "\nLogin successful!\n"
invalid_msg: .asciiz "\nInvalid ID entered! Try again.\n"
reg_msg:     .asciiz "\nRegistration complete!\n"
fail_msg: .asciiz "\nLogin failed. Try again.\n"
password_msg: .asciiz "Enter password: "

# =================== COUNTER MODULE ===================
counter_menu: .asciiz "\n--- Counter Menu ---\n1. Set Limit\n2. Set Speed\n3. Start Counter\n4. Back\nChoose: "
enter_limit: .asciiz "Enter limit (max count): "
enter_speed: .asciiz "Choose speed (1: Slow, 2: Normal, 3: Fast): "
starting_counter: .asciiz "\nStarting counter...\n"
wrong_password: .asciiz "\nIncorrect password. Returning to menu...\n"
#-------------------------------------------------------------

# Saved data (username and password)
saved_username: .space 100
saved_id: .word -1

# Main menu
menu:       .asciiz "\n====== Mini OS Simulator ======\n1. Calculator\n2. Counter\n3. Guess the Number\n4. Unit Converter\n5. Exit\nChoose an option: "
invalid:    .asciiz "Invalid choice. Try again.\n"
exit_msg:   .asciiz "\n[Exiting Mini OS... Goodbye!]\n"
newline:    .asciiz "\n"

# Calculator Messages
.data
#newline:            .asciiz "\n"
invalid_option: .asciiz "Invalid option, please try again.\n"
prompt_type:      .asciiz "\nEnter number type (i=int, f=float, d=double): "
prompt_num:       .asciiz "Enter number: "
prompt_op:        .asciiz "Enter operation (+, -, *, /): "
continue_prompt:  .asciiz "\nContinue on result? (y/n): "
result_msg:       .asciiz "Result: "
#newline:          .asciiz "\n"
error_msg:        .asciiz "Invalid input!\n"


# Guess
guess_intro: .asciiz "\nGuess the number between 1 and 100:\n"
guess_high:  .asciiz "Too high! Try again:\n"
guess_low:   .asciiz "Too low! Try again:\n"
guess_correct: .asciiz "Correct!\n"
# Unit Converter
unit_converter_prompt: .asciiz "\n===== Unit Converter =====\n1. Meter to Centimeter\n2. Kilogram to Gram\n3. Celsius to Fahrenheit\n4. Minutes to Seconds\n5. Go back to Menu\nChoose an option: "
conversion_result: .asciiz "Enter the number: "

# Buffer for user input
buffer: .space 20

.text
.globl main

main:
# Register/Login loop
auth_loop:
    li $v0, 4
    la $a0, welcome
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    beq $t0, 1, register
    beq $t0, 2, login
    j auth_loop
#calc
    li $t7, 0        # 0 = int, 1 = float, 2 = double
    li $t6, 0        # Flag: 0 = fresh input, 1 = continue with result

# Registration
register:
    li $v0, 4
    la $a0, username_msg
    syscall

    li $v0, 8
    la $a0, saved_username
    li $a1, 100
    syscall

    li $v0, 4
    la $a0, id_prompt
    syscall

    li $v0, 5
    syscall
    sw $v0, saved_id

    # ????? ID ???? ????? ??? ????? ??????
    lw $t1, saved_id
    addi $t2, $t1, 1  # ????? 1 ????? ?????? ????? ID ????
    sw $t2, saved_id

    li $v0, 4
    la $a0, success_msg
    syscall

    lw $a0, saved_id
    li $v0, 1
    syscall

    j auth_loop

# Login
login:
    li $v0, 4
    la $a0, login_prompt
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    lw $t2, saved_id
    beq $t1, $t2, login_success

    li $v0, 4
    la $a0, invalid_msg
    syscall
    j auth_loop

login_success:
    li $v0, 4
    la $a0, login_success_msg
    syscall
    j menu_loop

login_fail:
    li $v0, 4
    la $a0, fail_msg
    syscall
    j auth_loop

# MAIN MENU

menu_loop:
    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    beq $t0, 1, calculator
    beq $t0, 2, counter
    beq $t0, 3, guess
    beq $t0, 4, unit_converter
    beq $t0, 5, exit

    li $v0, 4
    la $a0, invalid_option
    syscall
    j menu_loop

# === Calculator Logic ===
calculator:
    li $t6, 0           # Reset continuation flag
    j calc_start

calc_start:
    # Ask for type only if not continuing
    beqz $t6, ask_type
    j read_op

ask_type:
    li $v0, 4
    la $a0, prompt_type
    syscall

    li $v0, 12       # Read char
    syscall
    move $t0, $v0

    li $t1, 'i'
    li $t2, 'f'
    li $t3, 'd'

    beq $t0, $t1, set_int
    beq $t0, $t2, set_float
    beq $t0, $t3, set_double
    j invalid_input

set_int:
    li $t7, 0
    j read_num1
set_float:
    li $t7, 1
    j read_num1
set_double:
    li $t7, 2
    j read_num1

read_num1:
    li $v0, 4
    la $a0, prompt_num
    syscall

    beq $t7, 0, read_int1
    beq $t7, 1, read_float1
    beq $t7, 2, read_double1

read_int1:
    li $v0, 5
    syscall
    move $t4, $v0   # result int
    j read_op

read_float1:
    li $v0, 6
    syscall
    mov.s $f4, $f0  # result float
    j read_op

read_double1:
    li $v0, 7
    syscall
    mov.d $f12, $f0 # result double
    j read_op

read_op:
    li $v0, 4
    la $a0, prompt_op
    syscall

    li $v0, 12
    syscall
    move $t5, $v0   # operator

read_num2:
    li $v0, 4
    la $a0, prompt_num
    syscall

    beq $t7, 0, read_int2
    beq $t7, 1, read_float2
    beq $t7, 2, read_double2

read_int2:
    li $v0, 5
    syscall
    move $t6, $v0
    j compute_int

read_float2:
    li $v0, 6
    syscall
    mov.s $f6, $f0
    j compute_float

read_double2:
    li $v0, 7
    syscall
    mov.d $f14, $f0
    j compute_double

compute_int:
    li $t1, '+'
    beq $t5, $t1, int_add
    li $t1, '-'
    beq $t5, $t1, int_sub
    li $t1, '*'
    beq $t5, $t1, int_mul
    li $t1, '/'
    beq $t5, $t1, int_div
    j invalid_input

int_add:
    add $t4, $t4, $t6
    j print_int
int_sub:
    sub $t4, $t4, $t6
    j print_int
int_mul:
    mul $t4, $t4, $t6
    j print_int
int_div:
    beqz $t6, invalid
    div $t4, $t6
    mflo $t4
    j print_int

compute_float:
    li $t1, '+'
    beq $t5, $t1, float_add
    li $t1, '-'
    beq $t5, $t1, float_sub
    li $t1, '*'
    beq $t5, $t1, float_mul
    li $t1, '/'
    beq $t5, $t1, float_div
    j invalid_input

float_add:
    add.s $f4, $f4, $f6
    j print_float
float_sub:
    sub.s $f4, $f4, $f6
    j print_float
float_mul:
    mul.s $f4, $f4, $f6
    j print_float
float_div:
    div.s $f4, $f4, $f6
    j print_float

compute_double:
    li $t1, '+'
    beq $t5, $t1, double_add
    li $t1, '-'
    beq $t5, $t1, double_sub
    li $t1, '*'
    beq $t5, $t1, double_mul
    li $t1, '/'
    beq $t5, $t1, double_div
    j invalid_input

double_add:
    add.d $f12, $f12, $f14
    j print_double
double_sub:
    sub.d $f12, $f12, $f14
    j print_double
double_mul:
    mul.d $f12, $f12, $f14
    j print_double
double_div:
    div.d $f12, $f12, $f14
    j print_double

print_int:
    li $v0, 4
    la $a0, result_msg
    syscall
    li $v0, 1
    move $a0, $t4
    syscall
    j ask_continue

print_float:
    li $v0, 4
    la $a0, result_msg
    syscall
    li $v0, 2
    mov.s $f12, $f4
    syscall
    j ask_continue

print_double:
    li $v0, 4
    la $a0, result_msg
    syscall
    li $v0, 3
    syscall
    j ask_continue

ask_continue:
    li $v0, 4
    la $a0, continue_prompt
    syscall

    li $v0, 12
    syscall
    li $t1, 'y'
    beq $v0, $t1, continue_calc

    li $t1, 'n'      # If user chooses 'n' for no
    beq $v0, $t1, return_to_menu

    li $v0, 10       # Exit the program if any other key is pressed
    syscall

continue_calc:
    li $t6, 1  # Flag to use previous result
    j read_op

return_to_menu:
    j menu_loop     # Jump to the menu loop

invalid_input:
    li $v0, 4
    la $a0, error_msg
    syscall
    j main
    j menu_loop


# COUNTER
counter:
    # Ask for password (default is 1234)
    li $v0, 4
    la $a0, password_msg
    syscall

    li $v0, 5
    syscall
    li $t9, 1234
    bne $v0, $t9, wrong_counter_pass

    # Default values
    li $s0, 10    # counter limit
    li $s1, 2     # speed option

counter_menu_loop:
    li $v0, 4
    la $a0, counter_menu
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $t1, 1
    beq $t0, $t1, counter_set_limit
    li $t1, 2
    beq $t0, $t1, counter_set_speed
    li $t1, 3
    beq $t0, $t1, counter_start
    li $t1, 4
    beq $t0, $t1, menu_loop
    j counter_menu_loop

counter_set_limit:
    li $v0, 4
    la $a0, enter_limit
    syscall

    li $v0, 5
    syscall
    move $s0, $v0
    j counter_menu_loop

counter_set_speed:
    li $v0, 4
    la $a0, enter_speed
    syscall

    li $v0, 5
    syscall
    move $s1, $v0
    j counter_menu_loop

counter_start:
    li $v0, 4
    la $a0, starting_counter
    syscall

    li $t2, 1  # Counter starts from 1
counter_loop:
    bgt $t2, $s0, counter_menu_loop

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    move $a1, $s1
    jal delay_loop

    addi $t2, $t2, 1
    j counter_loop

# Delay subroutine to simulate speed (slow/normal/fast)
delay_loop:
    li $t3, 0
    li $t5, 500000
    li $t6, 1000000
    li $t7, 2000000
    li $t8, 0
    beq $a1, 1, delay_slow
    beq $a1, 2, delay_normal
    beq $a1, 3, delay_fast
    jr $ra

delay_slow:
    move $t8, $t7
    j delay_run
delay_normal:
    move $t8, $t6
    j delay_run
delay_fast:
    move $t8, $t5
    j delay_run

delay_run:
    li $t3, 0
delay_loop_inner:
    addi $t3, $t3, 1
    blt $t3, $t8, delay_loop_inner
    jr $ra

wrong_counter_pass:
    li $v0, 4
    la $a0, wrong_password
    syscall
    j menu_loop

# GUESS
guess:
    li $a1, 100       
li $v0, 42        
syscall
addi $t1, $a0, 1
    li $v0, 4
    la $a0, guess_intro
    syscall

guess_loop:
    li $v0, 5
    syscall
    move $t0, $v0

    beq $t0, $t1, guess_correct_label
    bgt $t0, $t1, too_high
    blt $t0, $t1, too_low

too_high:
    li $v0, 4
    la $a0, guess_high
    syscall
    j guess_loop

too_low:
    li $v0, 4
    la $a0, guess_low
    syscall
    j guess_loop

guess_correct_label:
    li $v0, 4
    la $a0, guess_correct
    syscall
    j menu_loop
    
# UNIT CONVERTER
unit_converter:
    li $v0, 4
    la $a0, unit_converter_prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    beq $t0, 1, meter_to_centimeter
    beq $t0, 2, kilogram_to_gram
    beq $t0, 3, celsius_to_fahrenheit
    beq $t0, 4, minutes_to_seconds
    j menu_loop

meter_to_centimeter:
    li $v0, 4
    la $a0, conversion_result
    syscall

    li $v0, 5
    syscall
    move $t1, $v0
    li $t2, 100
    mul $t3, $t1, $t2

  
    li $v0, 4
    la $a0, result_msg  
    syscall

    li $v0, 1
    move $a0, $t3
    syscall
    j unit_converter

kilogram_to_gram:
    li $v0, 4
    la $a0, conversion_result
    syscall

    li $v0, 5
    syscall
    move $t1, $v0
    li $t2, 1000
    mul $t3, $t1, $t2

    
    li $v0, 4
    la $a0, result_msg  
    syscall

    li $v0, 1
    move $a0, $t3
    syscall
    j unit_converter

celsius_to_fahrenheit:
    li $v0, 4
    la $a0, conversion_result
    syscall

    li $v0, 5
    syscall
    move $t1, $v0
    li $t2, 9
    mul $t3, $t1, $t2
    li $t4, 5
    div $t3, $t4
    mflo $t5
    li $t6, 32
    add $t7, $t5, $t6

  
    li $v0, 4
    la $a0, result_msg  
    syscall

    li $v0, 1
    move $a0, $t7
    syscall
    j unit_converter

minutes_to_seconds:
    li $v0, 4
    la $a0, conversion_result
    syscall

    li $v0, 5
    syscall
    move $t1, $v0
    li $t2, 60
    mul $t3, $t1, $t2   # Now multiply by 60 to convert minutes to seconds

 
    li $v0, 4
    la $a0, result_msg 
    syscall

    li $v0, 1
    move $a0, $t3
    syscall
    j unit_converter

# EXIT
exit:
    li $v0, 4
    la $a0, exit_msg
    syscall
    li $v0, 10
    syscall
