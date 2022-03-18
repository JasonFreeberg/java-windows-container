FROM mcr.microsoft.com/windows/servercore:ltsc2019

# everything will be installed inside this directory inside the container
WORKDIR "C:/ProgramData"

# Install chocolately package manager
RUN @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin" -Y

# Install Open JDK 8
RUN choco install openjdk8 -Y
RUN refreshenv

# Copy Spring app
ADD target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
