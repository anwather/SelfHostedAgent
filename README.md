## Self Hosted Agent

1. Grab you devops organization name - click on Azure DevOps icon and copy the link - it should be something like htts://dev.azure.com/xxxxx

2. Generate a PAT token - click on Settings -> Personal Access Tokens -> + New Token

3. Click on **Show All Scopes** and under Agent Pools select **Read and Manage** .

4. Set a name for the token and click Create. Copy the value as it will not be shown again.

5. Edit ```./deploy.ps1``` and fill in the values for the parameters.

```
# Example
$location = "australiasoutheast" # Azure Location
$acrName = "awacr003vkkr" # Azure Container Registry Name (Must be globally unique)

$AZP_URL = "https://dev.azure.com/awworkspace" # Uri for the Azure DevOps organization
$AZP_TOKEN = "zpdq7c2e2i5igrdnxydccdkfd7iltcovxjfpvgjd2ue2mb2fv6bq" # Generate a PAT token with Agent Pool (Read and Manage Capabilities)
```

6. Run ```./deploy.ps1```