FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app
COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/sdk:7.0
WORKDIR /app
EXPOSE 5000
ENV ASPNETCORE_URLS http://*:5000
COPY --from=build-env /app/out .
ENTRYPOINT [ "dotnet", "contoso-pizza.dll" ]