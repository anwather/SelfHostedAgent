param principalId string
param principalKey string
param acrName string
param AZP_URL string
param AZP_TOKEN string

resource aci 'Microsoft.ContainerInstance/containerGroups@2020-11-01' = {
  name: 'devopsAgent'
  location: resourceGroup().location
  properties: {
    osType: 'Linux'
    imageRegistryCredentials: [
      {
        server: '${acrName}.azurecr.io'
        username: principalId
        password: principalKey
      }
    ]
    containers: [
      {
        name: 'agent01'
        properties: {
          resources: {
            requests: {
              cpu: 1
              memoryInGB: 2
            }
          }
          image: '${acrName}.azurecr.io/${acrName}/linuxagent:latest'
          environmentVariables: [
            {
              name: 'AZP_URL'
              value: AZP_URL
            }
            {
              name: 'AZP_TOKEN'
              value: AZP_TOKEN
            }
            {
              name: 'AZP_AGENT_NAME'
              value: uniqueString(acrName)
            }
          ]
        }
      }
    ]
  }
}
