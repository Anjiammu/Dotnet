<<<<<<< HEAD
FROM microsoft/aspnetcore-build:1.1 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out
=======
    
FROM microsoft/dotnet:2.1-sdk AS builder
WORKDIR /src
COPY . .
COPY "/TheExampleApp/TheExampleApp.csproj" "/TheExampleApp/"
COPY "/TheExampleApp.Tests/TheExampleApp.Tests.csproj" "/TheExampleApp.Tests/"
RUN dotnet restore "/TheExampleApp/TheExampleApp.csproj"
RUN dotnet build "/TheExampleApp/TheExampleApp.csproj" -c Release -o /app
RUN dotnet test "/TheExampleApp.Tests/TheExampleApp.Tests.csproj"
RUN dotnet publish -c Release -o /app/
>>>>>>> 95884c9bb314ad3696f6913ff015b91a2bb4a34d

# Build runtime image
FROM microsoft/aspnetcore:1.1
WORKDIR /app
<<<<<<< HEAD
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "aspnet-core-dotnet-core.dll"]
=======
ENV ASPNETCORE_ENVIRONMENT=Heroku
COPY --from=builder /app .
ENTRYPOINT ["dotnet", "/TheExampleApp/TheExampleApp.dll"]
>>>>>>> 95884c9bb314ad3696f6913ff015b91a2bb4a34d
