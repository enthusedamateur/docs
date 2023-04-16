This Powershell script will check file names up to the first - and then create folder matching this name up to the -. 

All files with names matching up to the - will then be moved into the newly created folder. 

This then loops until there are no further files in the directory. 

      # Set the source directory where the files are located
      $sourceDir = "\\truenas\Media\new-movies"
      
      # Get all the files in the source directory
      $files = Get-ChildItem $sourceDir
      
      # Loop through each file and move it to the appropriate folder
      foreach ($file in $files) {
          # Get the name of the file without the extension
          $nameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
      
          # Get the name of the folder to create
          $folderName = $nameWithoutExtension.Split('-')[0].Trim()
      
          # Create the full path for the new folder
          $newFolder = Join-Path $sourceDir $folderName
      
          # Create the new folder if it doesn't exist
          if (!(Test-Path $newFolder)) {
              New-Item -ItemType Directory -Path $newFolder | Out-Null
          }
      
          # Move the file to the new folder
          Move-Item $file.FullName $newFolder
      }
