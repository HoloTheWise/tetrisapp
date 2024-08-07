# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the project file and restore the dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the entire project and build the app
COPY . ./
RUN dotnet publish -c Release -o out

# Use the official ASP.NET Core runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Expose port 80
EXPOSE 80

# Set the entry point for the app
ENTRYPOINT ["dotnet", "TetrisApp.dll"]
