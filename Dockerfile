# Use official .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the project files
COPY . ./

# Restore and publish the application
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

# Use a smaller runtime image for deployment
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish ./

# Expose port 3000
EXPOSE 3000
ENTRYPOINT ["dotnet", "BE.dll"]
