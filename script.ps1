# GitHub API endpoint for branches
$apiUrl = "https://api.github.com/repos/kartikrc/terraform1/branches"

# Set your GitHub personal access token
$token = "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"

# Create a basic authentication header using the token
$headers = @{
    Authorization = "Bearer $token"
    Accept = "application/vnd.github.v3+json"
}

# Make the API request to get branch information
$response = Invoke-RestMethod -Uri $apiUrl -Headers $headers -Method Get

# Process the response and extract branch information
$branches = $response | ForEach-Object {
    $branchInfo = $_
    $branchDetailsUrl = $branchInfo.commit.url
    $branchDetails = Invoke-RestMethod -Uri $branchDetailsUrl -Headers $headers -Method Get

    [PSCustomObject]@{
        BranchName = $branchInfo.name
        CreatedDate = $branchDetails.commit.committer.date
        BranchOwner = $branchDetails.commit.committer.name
    }
}

# Display the results
$branches | Format-Table -AutoSize

