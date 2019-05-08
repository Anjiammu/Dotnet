FROM microsoft/dotnet:2.1-sdk AS builder
WORKDIR /src

COPY . .
COPY ["TheExampleApp/TheExampleApp.csproj" "TheExampleApp"/]
COPY ["TheExampleApp.Tests/TheExampleApp.Tests.csproj" "TheExampleApp.Tests"/]
RUN dotnet restore
RUN dotnet build TheExampleApp.csproj
RUN dotnet test TheExampleApp.Tests.csproj

FROM builder
WORKDIR /app
ENV ASPNETCORE_ENVIRONMENT=Heroku
COPY --from=builder /app .
ENTRYPOINT ["dotnet", "TheExampleApp.dll"]
