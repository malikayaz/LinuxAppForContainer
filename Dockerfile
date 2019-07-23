FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src
COPY ["LinuxAppForContainer/LinuxAppForContainer.csproj", "LinuxAppForContainer/"]
RUN dotnet restore "LinuxAppForContainer.csproj"
COPY . .
WORKDIR "/src/LinuxAppForContainer"
RUN dotnet build "LinuxAppForContainer.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "LinuxAppForContainer.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "LinuxAppForContainer.dll"]