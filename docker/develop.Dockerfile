FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base

WORKDIR /app

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false
ENV DOTNET_TieredPGO=1
ENV RUNNING_IN_DOCKER_DEVELOPMENT="true"

COPY ./docker-build ./
ENTRYPOINT ["dotnet", "ExampleWebApi.dll"]