param acrName string

resource acr 'Microsoft.ContainerRegistry/registries@2020-11-01-preview' = {
  name: toLower(acrName)
  location: resourceGroup().location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}
