[string[]] $folders = "Images", "Archives", "Exectutables", "Documents";
$folderToSort = $args[0];

function CreateFolders {
	Set-Location $folderToSort

	"Creating folder {0}..." -F $folder;
	New-Item -Path $folders -ItemType Directory -Force;		
}

function MoveFiles {
	
	$files = @{ 
		images = (Get-ChildItem *.jpg, *.png, *.bmp, *.webp, *.tiff, *.svg).FullName
		archives = (Get-ChildItem *.zip, *.tar, *.tar.gz, *.rar, *.tgz).FullName
		executables = (Get-ChildItem *.exe,*.msi).FullName
		documents =(Get-ChildItem *.pdf, *.doc, *.odt, *.csv, *.txt, *.xls, *xlsx, *.rtf, *.ppt, *.pptx, *.js, *.py, *.php, *.opvpn).FullName
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
	BEGIN { Write-Host "Starting..." }
	PROCESS {
		try { CreateFolders; MoveFiles}	
		catch { "An error has occured: {0}" -F ($_.toString()) }	
	}
	END { Write-Host "Files Moved"; Get-ChildItem}

}

Main
