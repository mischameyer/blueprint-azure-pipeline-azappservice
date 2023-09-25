# Introduction 
This blueprint shows how a Docker image (based on Linux) can be built on the basis of a simple dotnet Webapi on two variants and pushed to the Azure Container Registry via an Azure pipeline. Finally, the dockerimage is deployed on two AppServices in an Azure subscription.

# Variant 1 (multistep Pipeline)
In this variant, the dotnet restore / build / publish tasks are executed in the Azure pipeline and the docker build and push task uses the publish artifacts from the pipeline.
## Preconditions local
Clone Git repo locally and call docker build to build and run the image locally:
1. git clone https://github.com/mischameyer/blueprint-azure-pipeline-azappservice
2. Docker desktop must be installed locally
2. change to directory .\docker
3. start .\build-image.bat
4. start .\run-image.bat

## Azure DevOps Actions
Create a new pipeline at dev.azure.com and use the following yml file.
1. yml file for Pipeline: ./Pipelines/exampleapi-pipeline-azure-cd.yml
2. Execute the pipeline

# Variante 2 (singlestep Pipeline)
In this variant, dotnet restore / build / publish are executed in docker build based on dotnet SDK.
## Preconditions local
Clone Git repo locally and call docker build to build and run the image locally:
1. git clone https://github.com/mischameyer/blueprint-azure-pipeline-azappservice
2. change to directory .\ExampleWebApi
3. docker build -f .\developv2.dockerfile --force-rm -t examplewebapi .
4. docker run --rm -it examplewebapi

## Azure DevOps Actions
Create a new pipeline at dev.azure.com and use the following yml file.
1. yml file for Pipeline: ./Pipelines/exampleapi-pipeline-azure-cd-v2.yml
2. Execute pipeline


## Preconditions Azure
To place the Docker image on a container registry, an Azure Container Registry and a service connection of type "Docker Registry" are required. In addition, an AppService is used for deployment in an Azure Subscription.
1. Azure Container Registry: https://learn.microsoft.com/en-us/azure/container-registry/container-registry-get-started-portal?tabs=azure-cli
3. Enable Admin User on Azure Container Registry: https://learn.microsoft.com/en-us/azure/container-registry/container-registry-authentication?tabs=azure-cli
2. Create a Service Connection of type "Docker Registry": https://learn.microsoft.com/en-us/azure/devops/pipelines/ecosystems/containers/publish-to-acr?view=azure-devops&tabs=javascript%2Cportal%2Cmsi
3. Create an App Service Plan und App Service with operating system Linux: https://learn.microsoft.com/en-us/azure/app-service/overview
5. In the App Service under Configuration, store the Docker admin user and all parameters to enable a Docker pull from Azure Container Registry: DOCKER_CUSTOM_IMAGE_NAME, DOCKER_REGISTRY_SERVER_PASSWORD, DOCKER_REGISTRY_SERVER_URL, DOCKER_REGISTRY_SERVER_USERNAME
