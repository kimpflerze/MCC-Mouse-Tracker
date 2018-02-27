import { Component, OnInit } from '@angular/core';
import { trigger, state, style, animate, transition, keyframes } from '@angular/animations';
import { StatisticsService } from './statistics/statistics.service';
import { IStatistics } from './models/IStatistics';
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  
  currentStatistics: IStatistics;

  constructor(private _statisticsService: StatisticsService) {
    
  }

  ngOnInit() {
    this.getCurrentStatistics();
    
  }

  getCurrentStatistics() : void {
    this._statisticsService.getCurrentStatistics()
    .subscribe(
        alerts => { this.currentStatistics = alerts; }
    ); 
  }

}
