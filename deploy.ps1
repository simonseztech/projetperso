# Variables
$subscriptionId = "{ secrets.SUBS_ID }"
$clientId = "ad8692c5-f94e-46e6-848a-ed69aaaf2086"
#$clientId = "{ secrets.CLIENTS_ID }"
$clientSecret = "${ secrets.GITHUB_TOKEN }"
$tenantId = "${ secrets.TENANT_ID }"
$resourceGroupName = "rg-projetperso"
$location = "West Europe"
$terraformFilePath = "storage.tf"

# Connexion avec le service principal
az login --service-principal -u $clientId -p $clientSecret --tenant $tenantId

# Sélectionner l'abonnement
az account set --subscription $subscriptionId

# Créer le groupe de ressources si nécessaire
az group create --name $resourceGroupName --location $location

# Initialiser Terraform
terraform init -backend-config="storage_account_name=${secrets.storage_account}" `
                -backend-config="${container_name=secret.container_name}" `
                -backend-config="${key=secrets.backend_key}" `
                -backend-config="${access_key=secrets._access_key}"

# Appliquer le fichier Terraform
terraform apply -auto-approve
