$location = "" # Azure Location
$acrName = "" # Azure Container Registry Name (Must be globally unique)

$AZP_URL = "" # Uri for the Azure DevOps organization
$AZP_TOKEN = "" # Generate a PAT token with Agent Pool (Read and Manage Capabilities)

$guid = (New-Guid).Guid

$rg = New-AzResourceGroup -Name SelfHostedAgent -Location $location -Force -Verbose

$spn = New-AzADServicePrincipal -DisplayName "acr-pull-$guid" -Role AcrPull -Scope $rg.ResourceId -Verbose 

$key = New-AzADSPCredential -ObjectId $spn.Id

New-AzResourceGroupDeployment -ResourceGroupName SelfHostedAgent -TemplateFile .\acr.bicep -acrName $acrName -Verbose

az acr build --image $acrName/linuxagent --registry $acrName .

New-AzResourceGroupDeployment -ResourceGroupName SelfHostedAgent -TemplateFile .\aci.bicep -Verbose `
    -acrName $acrName `
    -principalId $spn.ApplicationId `
    -principalKey ($key.Secret | ConvertFrom-SecureString -AsPlainText) `
    -AZP_URL $AZP_URL `
    -AZP_TOKEN $AZP_TOKEN





