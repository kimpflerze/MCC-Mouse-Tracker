import { Component } from '@angular/core';
import { IStatistics } from '../models/IStatistics';
import { StatisticsService } from '../statistics/statistics.service';
import { AlertsService } from '../alerts/alerts.service';
import { IAlert } from '../models/IAlert';
import { OrdersService } from '../orders/orders.service';
import { IOrder } from '../models/IOrder';
import { AppSettings } from '../configuration/AppSettings';

@Component({
  selector: 'app-welcome',
  templateUrl: './welcome.component.html',
  styleUrls: ['./welcome.component.css']
})
export class WelcomeComponent {

  currentStatistics: IStatistics;
  alerts: IAlert[];
  orders: IOrder[];
  
    constructor(private _statisticsService: StatisticsService,
      private _alertsService: AlertsService,
      private _ordersService: OrdersService) {
      
    }
  
    ngOnInit() {
      this.getCurrentStatistics();
      this.getAlerts();
      this.getOrders();
      
    }
  
    getCurrentStatistics() : void {
      this._statisticsService.getCurrentStatistics()
      .subscribe(
          statistics => { this.currentStatistics = statistics; }
      ); 
    }

    getAlerts() : void {
      this._alertsService.getAlerts()
      .subscribe(
          alerts => { this.alerts = alerts; }
      ); 
    }

    getOrders() : void {
      this._ordersService.getOrders()
      .subscribe(
          orders => { this.orders = orders; }
      ); 
    }

    generateQrCodes(color?: string) {
      if(color) {
        window.open(AppSettings.baseUri + "qrcode?color=" + color, "_blank");
      } else {
        window.open(AppSettings.baseUri + "qrcode", "_blank");
      }
    }

}
