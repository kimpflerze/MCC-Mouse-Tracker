import { Injectable } from "@angular/core";
import { ISettings } from "../models/ISettings";
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/do';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { HttpErrorResponse } from "@angular/common/http/src/response";
import { AppSettings } from "../configuration/AppSettings";

@Injectable()
export class SettingsService {

    /** The URL used for making calls to the Settings API*/
    private _settingsUrl = AppSettings.baseUri + 'settings/1';

    /**
     * @constructor
     * @param _httpClient An HttpClient used for making calls to the Settings API
     */
    constructor(private _httpClient: HttpClient) { }

    /** Get the Settings */
    getSettings() : Observable<ISettings> {
        return this._httpClient.get<ISettings>(this._settingsUrl)
            .do(data => console.log('All: ' + JSON.stringify(data)))
            .catch(this.handleError);
    }

    /** 
     * Updates the settings 
     * @param model An ISettings representing updated settings
     */
    updateSettings(model : ISettings): Observable<ISettings> {
        console.log('Rows: ' + model.Id);

        return this._httpClient.put(this._settingsUrl, model , {
            headers: new HttpHeaders().set('Content-Type', 'application/json'),
          })
        .do(data => console.log('Posted ' + JSON.stringify(data)))
        .catch(this.handleError);
    }

    /** Logs errors that may occur during API calls */
    private handleError(err: HttpErrorResponse) {
        console.log(err.message);
        return Observable.throw(err.message);
    }
}