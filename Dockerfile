FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

RUN dotnet restore
RUN dotnet build TheExampleApp.csproj
RUN dotnet test TheExampleApp.Tests.csproj

COPY . .
FROM builder
WORKDIR /app
ENV ASPNETCORE_ENVIRONMENT=Heroku
COPY --from=builder /app .
ENTRYPOINT ["dotnet", "TheExampleApp.dll"]
