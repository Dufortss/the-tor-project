$DownloadCenterURL = "https://check.torproject.org/torbulkexitlist"
$Response = Invoke-RestMethod -URI $DownloadCenterURL
$csvFileData = $Response

write-host "File Fetch completed."

#decleration
$file = ".\torips.txt"
$text = $csvFileData
$wi = "#13 #14"

"Set config"
git config --global user.email "builduser@samik.local" # any values will do, if missing commit will fail
git config --global user.name "Build user"

"Select a branch"
git checkout main 2>&1 | write-host # need the stderr redirect as some git command line send none error output here and remove this later.

"Update the local repo"
git pull  2>&1 | write-host

"Status at start"
git status 2>&1 | write-host

"Update the file $file"
Add-Content -Path $file -Value $csvFileData

"Status prior to stage"
git status 2>&1 | write-host

"Stage the file"
git add $file  2>&1 | write-host

"Status prior to commit"
git status 2>&1 | write-host

"Commit the file"
git commit -m "Automated Repo Update"  2>&1 | write-host

"Status prior to push"
git status 2>&1 | write-host

"Push the change"
git push  2>&1 | write-host
