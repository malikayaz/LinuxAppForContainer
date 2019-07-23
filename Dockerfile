# Use microsoft/dotnet:2.1-aspnetcore-runtime-stretch-slim 
# from public Docker registry as base image.   
# Alias the image as base  
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim 
# Set /app as working directory.  
WORKDIR /app  
COPY *.csproj ./
RUN dotnet restore
COPY . ./
RUN dotnet publish -c Release -o out
FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch 
WORKDIR /app
COPY --from=build-env /app/out .
# Expose port 80 on Image.  
EXPOSE 80  
# Expose port 443 on Image.  
EXPOSE 443  
ENTRYPOINT ["dotnet", "LinuxAppForContainer.dll"]  