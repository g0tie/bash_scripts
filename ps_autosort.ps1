<#
.SYNOPSIS
Sort a files from a directory

.DESCRIPTION
Move files by extensions into the correct folders, if folder doesn't exist it will be create.
Folders are: Archives, Images, Executables and Documents

.OUTPUTS
When finished list folder to sort to confirm that files were moved

.EXAMPLE
PS> ps_autosort.ps1 .\Downloads

.LINK
Online version: https://github.com/g0tie/scripts

#>


[string[]] $folders = "Images", "Archives", "Exectutables", "Documents";
$folderToSort = $args[0];

if (!$folderToSort) {
	Write-Host "You must specify a directory";
	Exit;
}


function CreateFolders {
	Set-Location $folderToSort

	"Creating folder {0}..." -F $folder;
	New-Item -Path $HOME\$folders -ItemType Directory -Force;		
}

function MoveFiles {
	
	$files = @{ 
		images = (Get-ChildItem *.jpg, *.png, *.bmp, *.webp, *.tiff, *.svg).FullName
		archives = (Get-ChildItem *.zip, *.tar, *.tar.gz, *.rar, *.tgz).FullName
		executables = (Get-ChildItem *.exe,*.msi).FullName
		documents = (Get-ChildItem *.pdf, *.doc, *.odt, *.csv, *.txt, *.xls, *xlsx, *.rtf, *.ppt, *.pptx, *.js, *.py, *.php, *.opvpn).FullName
	}

	foreach ($file in $files.GetEnumerator()) { 
		switch ($file.Name) {
			images { $destination = $folders[0] }
			archives { $destination = $folders[1] }
			executables { $destination = $folders[2] }
			documents { $destination = $folders[3] }

		}
		
		if (! ($file.Value -eq $null)) { Move-Item $file.Value $destination }
	}		
}

function Main {
	BEGIN { Write-Host "Starting..."; Push-Location $folderToSort }
	PROCESS {
		try { CreateFolders; MoveFiles}	
		catch { "An error has occured: {0}" -F ($_.toString()) }	
	}
	END { Write-Host "Files Moved"; Get-ChildItem; Pop-Location $folderToSort}

}

Main
