# Unpin Microsoft Store app from taskbar
 $msstore = "Microsoft Store"
 ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $msstore}).Verbs() | ?{$_.Name.replace('&','') -match 'Unpin from taskbar'} | %{$_.DoIt(); $exec = $true}

# Unpin Default Mail app from taskbar
 $mail = "Mail"
 ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $mail}).Verbs() | ?{$_.Name.replace('&','') -match 'Unpin from taskbar'} | %{$_.DoIt(); $exec = $true}

# Turn off search box on taskbar. User can renable via GUI. 
 New-Item -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -name 'SearchboxTaskbarMode' -type 4 -value 0
 
# Diable Cortana button on taskbar


# Disable News and Weather on taskbar
 Set-ItemProperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds' -name 'ShellFeedsTaskbarViewMode' -type 4 -value 0


# Pin MS Apps to taskbar
