import { Component, OnInit } from '@angular/core';
import { AlertsService } from './alerts.service';
import { IAlert } from '../models/IAlert';
import { MatTableDataSource } from '@angular/material';

@Component({
  selector: 'app-alerts',
  templateUrl: './alerts.component.html',
  styleUrls: ['./alerts.component.css']
})
export class AlertsComponent implements OnInit {

  /** The columns displayed in the data table */
  displayedColumns = ['Id', 'Alert Type', 'Alert Date'];

  /** A list of all active alerts */
  alerts: IAlert[];

  /** The data source used by the data table */
  dataSource: MatTableDataSource<IAlert>;

  /**
   * @constructor
   * @param _alertService An AlertsService used to interact with the Alerts API
   */
  constructor(private _alertService: AlertsService) { }

  ngOnInit() {
    this.getAlerts();
  }

  /** Gets all active alerts and populates the data table */
  getAlerts() : void {
    this._alertService.getAlerts()
    .subscribe(
        alerts => { this.alerts = alerts; }
        , error => console.log(error)
        , () => this.dataSource = new MatTableDataSource(this.alerts)
    ); 
  }

}
