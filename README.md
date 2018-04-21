# MCC-Mouse-Tracker
Mouse breeding tracking application for Massey Cancer Center.

## Installation Instructions

[WebApi Installation Instructions](./WebAPI/Api/readme.md) 

[Web Application Installation Instructions](./WebApp/README.md)



## 2-17 API Deploy Notes

The following properties have been added to the response of the /settings endpoint:
* MaleInCageColor
* PupsInCageColor
* PupsToWeanColor
* MaleTooOldColor
* FemaleTooOldColor
* CageWithOrderColor
* OldFemaleAlertAdvance
* OldFemaleAlertAdvanceUnit
>The color properties are int values, so we just need to agree on an enum to map them to colors 

A 'MarkedForOrder' boolean property has been added to the response of the /sellingcage enpoint, indicating whether this cage is associated with an active order.
Additionally, a /cageorder endpoint has been created which allows you to mark a selling cage for an order.

### Example Call

```
Endpoint: /cageorder
Method: POST
Request Body:
    {
      "SellingCageId": "SellingCage1",
      "OrderId": "Order1",
      "NumberOfMice": 5 - (optional. Not sure if we actually need/want this)
    }
```
