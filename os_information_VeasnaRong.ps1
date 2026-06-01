<#
===========================================================================
Author: Veasna Rong
Script Name: OS Information
=========================================================================== 
#>

# Clear screen before start
Clear-Host

# Display the menu and set text colours
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "          System Information Menu          " -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "1. Operating system currently being used"
Write-Host "2. Windows remote service status"
Write-Host "3. Computer manufacturer and model"
Write-Host "4. Computer name"
Write-Host "5. Computer domain name"
Write-Host "6. Computer trusted hosts"
Write-Host "7. Operating system architecture"
Write-Host "8. Get all information"
Write-Host "9. Quit"
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "    Please enter a number from 1 to 9      "
Write-Host "        To view the information            "
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""


# Create a variable called $Choice and give it an initial value of 0.
# This variable will store the user's menu selection.
$Choice = 0

# 1. Operating system currently being used (OS name and version)
# Use Get-CimInstance cmdlet to retrieve info from Win32_OperatingSystem class (contains information about the OS)
# Then use pipe to pass the return info on to next command Select-Object cmdlet (select specific properties from an object)
# Then add -ExpandProperty (only the value is displayed), then Caption (OS Name) or Version (OS Version)
# Store in a created varible called, $OSName and $OSVersion
$OSName = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty Caption
$OSVersion = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty Version

# 2. Windows remote service status
# Use same method like in no. 1 (above) to retrieve data required
# But instead of Get-CimInstance, use Get-Service cmdlet
# Then store in a variable called $RemoteServiceName and $RemoteServiceStatus
$RemoteServiceName = Get-Service -Name WinRM | Select-Object -ExpandProperty DisplayName
$RemoteServiceStatus = Get-Service -Name WinRM | Select-Object -ExpandProperty Status

# 3. Computer manufacturer and model
# Use same method like in no. 1 (above) to retrieve data required,
# Then store data in variable called $ComputerManufacturer and $ComputerModel
$ComputerManufacturer = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -ExpandProperty Manufacturer
$ComputerModel = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -ExpandProperty Model

# 4. Computer name
# Use same method like in no. 1 (above) to retrieve data required, then store data in variable called $ComputerName
$ComputerName = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -ExpandProperty Name

# 5. Computer domain name
# Use same method like in no. 1 (above) to retrieve data required, then store data in variable called $DomainName
$DomainName = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -ExpandProperty Domain

# 6. Computer trusted hosts
# Use Get-Item cmdlet to retrieve the TrustedHosts configuration object from the WSMan (Windows Remote Management)
# WSMan:\localhost\Client\TrustedHosts is the location Where trusted hosts data is stored
# Then pass the return info via pipe to command Select-Object cmdlet (select specific properties from an object)
# Then add -ExpandProperty (only the value is displayed), then Value (TrustedHost Name)
# Create a varible called $TrustedHosts and store
$TrustedHosts = Get-Item WSMan:\localhost\Client\TrustedHosts | Select-Object -ExpandProperty Value

# 6. If TrustedHost is not configured/found
# Create a function called CheckTurstedHostStatus to contain the checking (if/else statements)
function CheckTurstedHostStatus {
    # Check whether the $TrustedHosts variable contains any data
    # IsNullOrWhiteSpace() returns True if:
    # - The variable is null or The variable is empty ("") or The variable contains only spaces
    # This allows us to determine whether any TrustedHosts have been configured.
    if ([string]::IsNullOrWhiteSpace($TrustedHosts))
    {
        # If no TrustedHosts are configured, display a message to the user.
        Write-Host "- No TrustedHost configured/found" -ForegroundColor Green
    }
    else
    {
        # If any TrustedHosts exist, display the value stored in the variable.
        Write-Host "- $TrustedHosts" -ForegroundColor Green
    }
}

# 7. Operating system architecture
# Use same method like in no. 1 (above) to retrieve data required, then store data in variable called $OSArchitecture
$OSArchitecture = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty OSArchitecture

# 8. Get all information
function GetAllInfo {

    Write-Host "Operating system currently being used:" -ForegroundColor Green
    Write-Host "- $OSName" -ForegroundColor Green
    Write-Host "- $OSVersion" -ForegroundColor Green
    Write-Host ""
    Write-Host "Windows remote service status:" -ForegroundColor Green
    Write-Host "- $RemoteServiceName" -ForegroundColor Green
    Write-Host "- Status: $RemoteServiceStatus" -ForegroundColor Green
    Write-Host ""
    Write-Host "Computer manufacturer and model:" -ForegroundColor Green
    Write-Host "- $ComputerManufacturer" -ForegroundColor Green
    Write-Host "- $ComputerModel" -ForegroundColor Green
    Write-Host ""
    Write-Host "Computer name:" -ForegroundColor Green
    Write-Host "- $ComputerName" -ForegroundColor Green
    Write-Host ""
    Write-Host "Computer domain name:" -ForegroundColor Green
    Write-Host "- $DomainName" -ForegroundColor Green
    Write-Host ""
    Write-Host "Computer trusted hosts:" -ForegroundColor Green
    CheckTurstedHostStatus
    Write-Host ""
    Write-Host "Operating system architecture:" -ForegroundColor Green
    Write-Host "- $OSArchitecture" -ForegroundColor Green
    Write-Host ""
}

# Start a do loop.
# A do loop executes the code inside the braces at least once before
# checking the condition at the bottom of the loop.
do {
    
    # Start a try block.
    # Any errors that occur inside this block can be caught and handled
    # by the catch block below.
    try
    {

        # Get the user to input a number from the menu option and store in the variable "$Choice"
        $Choice = Read-Host "Please enter a menu number"

        # Convert the user's input from a string to an integer.
        $Choice = [int]$Choice

        # Check whether the user entered a valid menu option.
        # -lt means "less than"
        # -or means "either condition can be true"
        # -gt means "greater than"
        # If the number is less than 1 OR greater than 9,
        # it is an invalid menu selection.
        if ($Choice -lt 1 -or $Choice -gt 9)
        {
            # Manually generate an error using the throw statement.
            # The generated error will be sent directly to the catch block.
            throw "Invalid selection."
        }

        # Use a switch statement to determine which menu option the user selected.
        switch ($Choice) {

                # Choice 1 - Display "Operating system currently being used"
                1 {
                    # Display retrieved data from variables: $OSName and $OSVersion
                    # set text to green
                    Write-Host "Operating system currently being used:" -ForegroundColor Green
                    Write-Host "- $OSName" -ForegroundColor Green
                    Write-Host "- $OSVersion" -ForegroundColor Green
                    Write-Host ""
                }

                # Choice 2 - Display "Windows remote service status"
                2 {
                    # Display retrieved data from variables: $RemoteServiceName and $RemoteServiceStatus
                    # set text to green
                    Write-Host "Windows remote service status:" -ForegroundColor Green
                    Write-Host "- $RemoteServiceName" -ForegroundColor Green
                    Write-Host "- Status: $RemoteServiceStatus" -ForegroundColor Green
                    Write-Host ""
                }

                # Choice 3 - Display "Computer manufacturer and model"
                3 {
                    # Display retrieved data from variables: $ComputerManufacturer and $ComputerModel
                    # set text to green
                    Write-Host "Computer manufacturer and model:" -ForegroundColor Green
                    Write-Host "- $ComputerManufacturer" -ForegroundColor Green
                    Write-Host "- $ComputerModel" -ForegroundColor Green
                    Write-Host ""
                }

                # Choice 4 - Display "Computer name"
                4 {
                    # Display retrieved data from variable: $ComputerName
                    # set text to green
                    Write-Host "Computer name:" -ForegroundColor Green
                    Write-Host "- $ComputerName" -ForegroundColor Green
                    Write-Host ""
                }

                # Choice 5 - Display "Computer domain name"
                5 {
                    # Display retrieved data from variable: $DomainName
                    # set text to green
                    Write-Host "Computer domain name:" -ForegroundColor Green
                    Write-Host "- $DomainName" -ForegroundColor Green
                    Write-Host ""
                }

                # Choice 6 - Display "Computer trusted hosts"
                6 {
                    # Display retrieved data from function: CheckTurstedHostStatus
                    # set text to green
                    Write-Host "Computer trusted hosts:" -ForegroundColor Green
                    CheckTurstedHostStatus
                    Write-Host ""
                }

                # Choice 7 - Display "Operating system architectures"
                7 {
                    # Display retrieved data from variable: $OSArchitecture
                    # set text to green
                    Write-Host "Operating system architecture:" -ForegroundColor Green
                    Write-Host "- $OSArchitecture" -ForegroundColor Green
                    Write-Host ""
                }

                # Choice 8 - Display "Computer trusted hosts"
                8 {
                    # Display retrieved data from function: 
                    # set text to green
                    Write-Host "Get all information" -ForegroundColor Green
                    GetAllInfo
                    Write-Host ""
                }

                # Choice 9 - Quit
                9 {
                    # Display exiting statement
                    Write-Host "Exiting the menu..." -ForegroundColor Green
                
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
        # - The user enters a number outside the range 1 to 9
        Write-Host "Error: invalid input - Please try again." -ForegroundColor Red
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