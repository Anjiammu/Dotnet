FROM microsoft/dotnet:2.1-sdk AS builder
WORKDIR /src

COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app/

FROM builder
WORKDIR /app
ENV ASPNETCORE_ENVIRONMENT=Heroku
COPY --from=builder /app .
ENTRYPOINT ["dotnet", "TheExampleApp.dll"]
