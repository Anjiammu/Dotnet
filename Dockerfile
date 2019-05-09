FROM microsoft/dotnet:2.1-sdk AS builder
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY "/aspnet-core-dotnet-core.csproj" "/"
RUN dotnet restore "/aspnet-core-dotnet-core.csproj"

# Copy everything else and build
COPY . .
RUN dotnet build "/aspnet-core-dotnet-core.csproj"
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/aspnetcore:1.1
WORKDIR /app
COPY --from=builder /app/out .
ENTRYPOINT ["dotnet", "aspnet-core-dotnet-core.dll"]
