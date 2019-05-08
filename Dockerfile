    
FROM microsoft/dotnet:2.1-sdk AS builder
WORKDIR /src
COPY . .
COPY "TheExample.csproj" /src
COPY "TheExample.Tests.csproj" /src
RUN dotnet restore "TheExample.csproj"
RUN dotnet build "TheExample.csproj" -c Release -o /app
RUN dotnet test "TheExample.Tests.csproj"
RUN dotnet publish -c Release -o /app/

FROM microsoft/aspnetcore:2.2
WORKDIR /app
ENV ASPNETCORE_ENVIRONMENT=Heroku
COPY --from=builder /app .
ENTRYPOINT ["dotnet", "TheExampleApp.dll"]
