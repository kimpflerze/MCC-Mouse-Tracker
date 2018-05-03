
# MouseTrackWeb

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 1.5.4.

## Installation Instructions

Note: The Angular CLI must be installed in order to build the application. (run npm install -g @angular/cli to install the Angular CLI globally).

Before building the application, the baseUri property in /src/app/configuration/AppSettings.ts MUST be changed to the correct Uri of the MCC-Mouse-Tracker WebApi.

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `-prod` flag for a production build.

## IIS Hosting

If the application is hosted using IIS, the URL Rewrite module must be installed on the server. The Module can be downloaded here: https://www.iis.net/downloads/microsoft/url-rewrite

Also, the following web.config file needs to be added to the directory containing the buid artifacts: 

```xml
<configuration>
<system.webServer>
  <rewrite>
    <rules>
      <rule name="Angular Routes" stopProcessing="true">
        <match url=".*" />
	  <conditions logicalGrouping="MatchAll">
	    <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
	    <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
	  </conditions>
	  <action type="Rewrite" url="/" />
      </rule>
    </rules>
  </rewrite>
</system.webServer>
</configuration>
```
NOTE: The url property must be updated to match the path of the website (The value "/" is only used for a website at the root).
Credit: https://blogs.msdn.microsoft.com/premier_developer/2017/06/14/tips-for-running-an-angular-app-in-iis/
## Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI README](https://github.com/angular/angular-cli/blob/master/README.md).
