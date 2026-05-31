<#
===========================================================================
Author: Veasna Rong
Script Name: OS Information
=========================================================================== 
#>

# Clear screen
Clear-Host

# Display the menu and set text colour to cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "          System Information Menu          " -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Operating system currently being used"
Write-Host "2. Windows remote service status"
Write-Host "3. Computer manufacturer and model"
Write-Host "4. Computer name"
Write-Host "5. Computer domain name"
Write-Host "6. Computer trusted hosts"
Write-Host "7. Operating system architecture"
Write-Host "8. Get all information"
Write-Host "9. Quit"
Write-Host ""
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""


# Create a variable called $Choice and give it an initial value of 0.
# This variable will store the user's menu selection.
$Choice = 0


# Start a do loop.
# A do loop executes the code inside the braces at least once before
# checking the condition at the bottom of the loop.
do {
    
    # Start a try block.
    # Any errors that occur inside this block can be caught and handled
    # by the catch block below.
    try
    {

        # Get the user to input a number from the menu option and store in the variable "$choice"
        $Choice = Read-Host "Please select an option from the menu (1 - 9)"

        # Convert the user's input from a string to an integer.
        $Choice = [int]$Choice

        # Check whether the user entered a valid menu option.
        # -lt means "less than"
        # -or means "either condition can be true"
        # -gt means "greater than"
        #
        # Therefore:
        # If the number is less than 1 OR greater than 9,
        # it is an invalid menu selection.
        if ($Choice -lt 1 -or $Choice -gt 9)
        {
            # Manually generate an error using the throw statement.
            # The generated error will be sent directly to the catch block.
            throw "Invalid selection."
        }

        # Use a switch statement to determine which menu option
        # the user selected.
        switch ($Choice) {

                # Option 1 - Display "Operating system currently being used"
                1 {
                    # Display info
                    Write-Host "option 1"
                    Write-Host ""
                }

                # Option 2 - Display "Windows remote service status"
                2 {
                    # Display info
                    Write-Host "option 2 - Windows remote service status"
                    Write-Host ""
                }

                # Option 3 - Display "Computer manufacturer and model"
                3 {
                    # Display info
                    Write-Host "option 3 - Computer manufacturer and model"
                    Write-Host ""
                }

                # Option 4 - Display "Computer name"
                4 {
                    # Display info
                    Write-Host "option 4 - Computer name"
                    Write-Host ""
                }

                # Option 5 - Display "Computer domain name"
                5 {
                    # Display info
                    Write-Host "option 5 - Computer domain name"
                    Write-Host ""
                }

                # Option 6 - Display "Computer trusted hosts"
                6 {
                    # Display info
                    Write-Host "option 6 - Computer trusted hosts"
                    Write-Host ""
                }

                # Option 7 - Display "Operating system architectures"
                7 {
                    # Display info
                    Write-Host "option 7 - Operating system architecture"
                    Write-Host ""
                }

                # Option 8 - Display "Computer trusted hosts"
                8 {
                    # Display info
                    Write-Host "option 8 - Computer trusted hosts"
                    Write-Host ""
                }

                # Option 9 - Quit
                9 {
                    # Display info
                    Write-Host "option 9 - Exiting menu"
                
                }
            }
        }

    # Start the catch block.
    # If an error occurs in the try block, PowerShell immediately
    # jumps to this section.
    catch
    {
        # Display an error message in red text.
        # This will occur if:
        # - The user enters text such as "abc"
        # - The user enters a number outside the range 1 to 3
        Write-Host "Error invalid input: Please try again." -ForegroundColor Red
        Write-Host ""
    }

}
while ($Choice -ne 9)

# Explanation of the while condition:
# -ne means "not equal to"
#
# If $Choice is NOT equal to 9:
#     The menu is displayed again.
#
# If $Choice IS equal to 9:
#     The condition becomes false and the loop ends.
#
# Therefore, the program continues running until the user
# selects option 9 (Exit)