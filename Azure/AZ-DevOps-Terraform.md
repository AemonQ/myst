```
# create resource group
az group create -l westus -n terraform-rg
```

```
az ad sp create-for-rbac -n terraform-rg --role contributor --scopes /subscriptions/35674df3-ab44-4e63-8f2e-64329a24626f/resourceGroups/terraform-rg
```

Now go to AZ DevOps, connect your Repo and add the Azure Resource Group Service connection through the Settings.

```
az storage account create --resource-group terraform-rg --name tfblobstrg --sku Standard_LRS --encryption-services blob
```
get the keys
```
az storage account keys list --resource-group terraform-rg --account-name tfblobstrg
```

create the container:
```
az storage sontainer create --name tfcontainer --account-name tfblobstrg --account-key ^the key we got^
```

create the terraform file