<#
===========================================================================
Author: Veasna Rong
Script Name: OS Information
=========================================================================== 
#>

# Clear screen before starting
Clear-Host

#========================================= MENU =========================================#

# Create a function called MainMenu to contain the menu output
function MainMenu {
# Display the menu and set text colours titles to Cyan
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
}

#========================================= VARIABLES =========================================#

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

# 7. Operating system architecture
# Use same method like in no. 1 (above) to retrieve data required, then store data in variable called $OSArchitecture
$OSArchitecture = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty OSArchitecture

#========================================= FUNCTIONS =========================================#

# 1. Operating system currently being used (OS name and version)
# Create a function called GetOSNameVersion to contain data from varibles: $OSName and $OSVersion
function GetOSNameVersion {
    # Display retrieved data from variables: $OSName and $OSVersion
    # set text to green
    Write-Host "Operating system currently being used:" -ForegroundColor Green
    Write-Host "- $OSName" -ForegroundColor Green
    Write-Host "- $OSVersion" -ForegroundColor Green
    Write-Host ""
}

# 2. Windows remote service status
# Create a function called GetRemoteServiceStatus to contain data from varibles: $RemoteServiceName and $RemoteServiceStatus
function GetRemoteServiceStatus {
    # Display retrieved data from variables: $RemoteServiceName and $RemoteServiceStatus
    # set text to green
    Write-Host "Windows remote service status:" -ForegroundColor Green
    Write-Host "- $RemoteServiceName" -ForegroundColor Green
    Write-Host "- Status: $RemoteServiceStatus" -ForegroundColor Green
    Write-Host ""
}

# 3. Computer manufacturer and model
# Create a function called GetComputerManuMode to contain data from varibles: $ComputerManufacturer and $ComputerModel
function GetComputerManuMode {
    # Display retrieved data from variables: $ComputerManufacturer and $ComputerModel
    # set text to green
    Write-Host "Computer manufacturer and model:" -ForegroundColor Green
    Write-Host "- $ComputerManufacturer" -ForegroundColor Green
    Write-Host "- $ComputerModel" -ForegroundColor Green
    Write-Host ""
}

# 4. Computer name
# Create a function called GetComputerName to contain data from varible: $ComputerName
function GetComputerName {
    # Display retrieved data from variable: $ComputerName
    # set text to green
    Write-Host "Computer name:" -ForegroundColor Green
    Write-Host "- $ComputerName" -ForegroundColor Green
    Write-Host ""
}

# 5. Computer domain name
# Create a function called GetComputerDomainName to contain data from varible: $ComputerName
function GetComputerDomainName {
    # Display retrieved data from variable: $DomainName
    # set text to green
    Write-Host "Computer domain name:" -ForegroundColor Green
    Write-Host "- $DomainName" -ForegroundColor Green
    Write-Host ""
}

# 6. Computer trusted hosts 
# Create a function called CheckTurstedHostStatus to contain the checking (if/else statements)
function GetTurstedHostStatus {
    # Check whether the $TrustedHosts variable contains any data
    # IsNullOrWhiteSpace() returns True if:
    # The variable is null or The variable is empty ("") or The variable contains only spaces
    # This allows us to determine whether any TrustedHosts have been configured.
    if ([string]::IsNullOrWhiteSpace($TrustedHosts))
    {
        # set text to green and display "Computer trusted hosts:"
        Write-Host "Computer trusted hosts:" -ForegroundColor Green
        # If no TrustedHosts are configured, display a message to the user.
        Write-Host "- No TrustedHost configured/found" -ForegroundColor Green
        Write-Host ""
    }
    else
    {
        # set text to green and display "Computer trusted hosts:"
        Write-Host "Computer trusted hosts:" -ForegroundColor Green
        # If any TrustedHosts exist, display the value stored in the variable.
        Write-Host "- $TrustedHosts" -ForegroundColor Green
        Write-Host ""
    }
}

# 7. Operating system architecture
# Create a function called GetOSArchitectureto contain data from varible: $OSArchitecture
function GetOSArchitecture {
        # Display retrieved data from variable: $OSArchitecture
        # set text to green
        Write-Host "Operating system architecture:" -ForegroundColor Green
        Write-Host "- $OSArchitecture" -ForegroundColor Green
        Write-Host ""
}

# 8. Get all information
# Create a function called GetAllInfo and contain all previous functions (1-7) above  
function GetAllInfo {
    # set text to green and display "All System Information:" 
    Write-Host "All System Information:" -ForegroundColor Green
    # Funtion: 1. Operating system currently being used
    GetOSNameVersion
    # Funtion: 2. Windows remote service status
    GetComputerManuMode
    # Funtion: 3. Computer manufacturer and model
    GetComputerManuMode
    # Funtion: # 4. Computer name
    GetComputerName
    # Funtion: 5. Computer domain name
    GetComputerDomainName
    # Funtion: 6. Computer trusted hosts
    GetTurstedHostStatus
    # Funtion: 7. Operating system architecture
    GetOSArchitecture
}

#========================================= SCRIPTS =========================================#

function MainFunction { 

    # Call this funtion MainMenu to display the menu
    MainMenu

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
                        # Display retrieved data from function: GetOSNameVersion
                        GetOSNameVersion
                    }

                    # Choice 2 - Display "Windows remote service status"
                    2 {
                        # Display retrieved data from function: GetRemoteServiceStatus
                        GetRemoteServiceStatus
                    }

                    # Choice 3 - Display "Computer manufacturer and model"
                    3 {
                        # Display retrieved data from function: GetComputerManuMode
                        GetComputerManuMode
                    }

                    # Choice 4 - Display "Computer name"
                    4 {
                        # Display retrieved data from function: GetComputerName
                        GetComputerName
                    }

                    # Choice 5 - Display "Computer domain name"
                    5 {
                        # Display retrieved data from function: GetComputerDomainName
                        GetComputerDomainName
                    }

                    # Choice 6 - Display "Computer trusted hosts"
                    6 {
                        # Display retrieved data from function: GetTurstedHostStatus
                        GetTurstedHostStatus
                    }

                    # Choice 7 - Display "Operating system architectures"
                    7 {
                        # Display retrieved data from function: GetOSArchitecture
                        GetOSArchitecture
                    }

                    # Choice 8 - Display "Computer trusted hosts"
                    8 {
                        # Display retrieved data from function: GetAllInfo
                        GetAllInfo
                    }

                    # Choice 9 - Quit
                    9 {
                        # Display exiting statement
                        Write-Host "Exiting the menu..." -ForegroundColor Green
                
                    }
                }
            }

        # Start the catch block.
        # If an error occurs in the try block, immediately jumps to this section.
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
    # Use a while condition
    # note: -ne means "not equal to"
    # If $Choice is NOT equal to 9 - continue to loop.
    # If $Choice is equal to 9 - The condition becomes false and then exit loop.
    while ($Choice -ne 9)
}

# Call this function MainFunction to load the following scripts
MainFunction