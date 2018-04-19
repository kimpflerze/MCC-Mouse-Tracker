# Mouse Api

## Installation Instructions

The following line must be updated in the Web.config in order for the WebApi to communicate with the appropriate MySQL Database:

```xml
<connectionStrings>
    <add name="TestDb" providerName="MySql.Data.MySqlClient" connectionString="server={MySql Server Name};port=3306;database={MySql Schema};uid={username};password={password}" />
</connectionStrings>
```

* MySql Server Name - The MySqlServer name or IP of the MySql server to connect to.
* MySql Schema - The MySql Schema to use.
* username - The username of the service account that the WebApi will use to interact with the MySql Database.
* password - The passwrod of the service account that the WebApi will use to interact with the MySql Database.
