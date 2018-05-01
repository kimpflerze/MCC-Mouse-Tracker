# Data Needed in Tables

The following data must be inserted into the Database for the application to function properly. 
(NOTE: The settings values inserted are simply defaults that we used for testing. These values should be updated to fit the needs of the MCC)

```sql
insert into settings values (1, 10, 6, 3, 30, 30, 30, 100, 100, 2.50, 2.50, 2.50, 30, 30, 30, 30, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 3, 4, 5, 6);
insert into time_units values (1, 'Days');
insert into time_units values (2, 'Weeks');
insert into time_units values (3, 'Months');
insert into time_units values (4, 'Years');
insert into alert_type values (1, 'Wean Cage');
insert into alert_type values (2, 'Old Breeding Male');
insert into alert_type values (3, 'Old Breeding Female');
```
