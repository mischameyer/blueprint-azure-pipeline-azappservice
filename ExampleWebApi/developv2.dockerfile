FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
 
COPY ["ExampleWebApi/ExampleWebApi.csproj", "ExampleWebApi/"]
COPY . .
WORKDIR "/src/ExampleWebApi"
 
FROM build AS publish
RUN dotnet publish "ExampleWebApi.csproj" -c Release -o /app/publish
 
FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine3.18 AS base
 
WORKDIR /app

ENV RUNNING_IN_DOCKER_DEVELOPMENT="true"
ENV ASPNETCORE_ENVIRONMENT=Development
ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000
 
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ExampleWebApi.dll"]