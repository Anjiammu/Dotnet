    
FROM microsoft/dotnet:2.1-sdk AS builder
WORKDIR /src
COPY . .
COPY "/TheExampleApp/TheExampleApp.csproj" "/TheExampleApp/"
COPY "/TheExampleApp.Tests/TheExampleApp.Tests.csproj" "/TheExampleApp.Tests/"
RUN dotnet restore "/TheExampleApp/TheExampleApp.csproj"
RUN dotnet build "/TheExampleApp/TheExampleApp.csproj" -c Release -o /app
RUN dotnet test "/TheExampleApp.Tests/TheExampleApp.Tests.csproj"
RUN dotnet publish -c Release -o /app/

FROM microsoft/aspnetcore:2.2
WORKDIR /app
ENV ASPNETCORE_ENVIRONMENT=Heroku
COPY --from=builder /app .
ENTRYPOINT ["dotnet", "/TheExampleApp/TheExampleApp.dll"]
