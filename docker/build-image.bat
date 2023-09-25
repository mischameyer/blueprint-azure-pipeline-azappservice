rmdir docker-build /q /s
dotnet publish -c Release ..\ExampleWebApi\ -o docker-build
docker build -f .\develop.Dockerfile --force-rm -t examplewebapi .

