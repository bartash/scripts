# List the jobs managed by the Background Intelligent Transfer
# Service (BITS) (which runs inside a Windows Service Host
# svchost.exe container)
#
# must be admin
#!/bin/bash

# Query PowerShell to check for Windows Administrator privileges
is_win_admin=$(powershell.exe -NoProfile -Command "
    ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
" | tr -d '\r')

if [ "$is_win_admin" = "True" ]; then
    echo "✅ Running with elevated Windows Administrator privileges."
    # Put your BITS or system commands here
    bitsadmin.exe /list /allusers
else
    echo "❌ ERROR: This script requires elevated Windows Administrator privileges."
    echo "Please restart your Windows Terminal/WSL instance as an Administrator."
    exit 1
fi
