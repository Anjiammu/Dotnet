    
FROM microsoft/dotnet:2.1-sdk AS builder
WORKDIR /src
COPY . .
RUN dotnet restore "app.csproj"
RUN dotnet build "app.csproj" -c Release -o /app
RUN dotnet test "Tests.csproj"
RUN dotnet publish -c Release -o /app/

FROM microsoft/aspnetcore:2.2
WORKDIR /app
ENV ASPNETCORE_ENVIRONMENT=Heroku
COPY --from=builder /app .
ENTRYPOINT ["dotnet", "TheExampleApp.dll"]
