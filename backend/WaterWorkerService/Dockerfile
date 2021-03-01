#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/runtime:5.0-buster-slim AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build
WORKDIR /src
COPY ["WaterWorkerService.csproj", ""]
RUN dotnet restore "./WaterWorkerService.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "WaterWorkerService.csproj" -c Release -o /app/build
EXPOSE 3072 1433 4022 135 1434 443 80/tcp

FROM build AS publish
RUN dotnet publish "WaterWorkerService.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "WaterWorkerService.dll"]