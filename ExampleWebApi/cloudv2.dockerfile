
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base

WORKDIR app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR src
COPY . .

RUN dotnet restore 

RUN dotnet build "./ExampleWebApi/ExampleWebApi.csproj" -c Release -o appbuild

FROM build AS publish
RUN dotnet publish "./ExampleWebApi/ExampleWebApi.csproj" -c Release -o apppublish -p UseAppHost=false

FROM base AS final
WORKDIR app
COPY --from=publish src/apppublish .
ENTRYPOINT ["dotnet", "ExampleWebApi.dll"]