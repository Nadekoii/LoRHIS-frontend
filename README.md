# LoRHIS - Front-end
The Front-end of the LoRHIS project

## Github Repositories
All of the repositories for the LoRHIS project can be found below:

[LoRHIS - Front-end](https://github.com/Nadekoii/LoRHIS-frontend)

[LoRHIS - Back-end](https://github.com/Nadekoii/LoRHIS-backend)

[LoRHIS - Setup](https://github.com/Nadekoii/LoRHIS-setup)

## Recommended IDE
This IDE was originally used for the development of the project:
[IntelliJ](https://www.jetbrains.com/idea/)

## System Requirement
Node.js is required to run the project:
[Node.js](https://nodejs.org/en/download/package-manager)

## Project's Front-end Manual Setup
### Setup
1. Clone the Front-end repository
2. Navigate to Front-end directory
3. Install the dependencies with:
```sh
npm install                             # Install project's dependencies
npm install --save-dev vue-svg-loader   # Install the svg loader package
npm install axios                       # Install the axios package
```

### Compile and Hot-Reload for Development
```sh
npm run dev
```

## Known bug
### Downlink API
The Downlink API will always reply with Error 400 even with a Success, that's why the code will catch every error and ignore them. Fix the try-catch algorithm when the Downlink API is fixed on the server.
