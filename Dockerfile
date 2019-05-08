    
FROM microsoft/dotnet:2.1-sdk AS builder
WORKDIR /src

RUN dotnet restore
RUN dotnet build "app.csproj"
RUN dotnet test "Tests.csproj"
RUN dotnet publish -c Release -o /app/

FROM microsoft/aspnetcore:2.2
WORKDIR /app
ENV ASPNETCORE_ENVIRONMENT=Heroku
COPY --from=builder /app .
ENTRYPOINT ["dotnet", "TheExampleApp.dll"]
