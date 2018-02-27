import { Component, OnInit } from '@angular/core';
import { ISettings } from '../models/ISettings';
import { SettingsService } from './settings.service';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-settings',
  templateUrl: './settings.component.html',
  styleUrls: ['./settings.component.css']
})
export class SettingsComponent implements OnInit {

  /** The settings model */
  model: ISettings;
  errorMessage: any;

  /** The mapping from int values to time values */
  units = [
    { value: 1, text: 'Days' },
    { value: 2, text: 'Weeks' },
    { value: 3, text: 'Months'},
    { value: 4, text: 'Years'}
  ];

  /**
   * @constructor
   * @param _settingsService A SettingsService used for interacting with the Settings API
   */
  constructor(private _settingsService: SettingsService) { }

  ngOnInit(): void {
    this.getSettings();
  }

  /** 
   * Updates the settings
   * @param form An NgForm containing the updated settings 
   */
  submitForm(form: NgForm): void {
    this.model.Id = 1;
    this._settingsService.updateSettings(this.model)
      .subscribe(result => console.log(result)
      , error => console.log(error)
      , () => this.getSettings());
    
  }

  /** Get the settings */
  getSettings() : void {
    this._settingsService.getSettings()
    .subscribe(
        settings => { this.model = settings; }
        , error => console.log(error)
    ); 
  }
}