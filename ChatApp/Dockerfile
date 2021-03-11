# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY ChatApp/ChatApp.csproj ChatApp/
RUN dotnet restore ChatApp/ChatApp.csproj 

# copy and build app and libraries
COPY ChatApp/ ChatApp/
WORKDIR /source/ChatApp
RUN dotnet build -c release --no-restore

FROM build AS publish
RUN dotnet publish -c release --no-build -o /app

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:5001
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "ChatApp.dll"]