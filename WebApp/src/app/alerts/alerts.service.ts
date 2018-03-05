import { Injectable } from "@angular/core";
import { ISettings } from "../models/ISettings";
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/do';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { HttpErrorResponse } from "@angular/common/http/src/response";
import { AppSettings } from "../configuration/AppSettings";
import { IOrder } from "../models/IOrder";
import { IAlert } from "../models/IAlert";

@Injectable()
export class AlertsService {
    
    /** The URL used for making GET calls to the Alerts API */
    private _getUrl = AppSettings.baseUri + 'alert';

    /**
     * @constructor
     * @param _httpClient An HttpClient used for interacting with the Alerts API
     */
    constructor(private _httpClient: HttpClient) {
    }

    /** Retrieves all Alerts */
    getAlerts() : Observable<IAlert[]> {
        return this._httpClient.get<IAlert[]>(this._getUrl)
            .do(data => console.log('All: ' + JSON.stringify(data)))
            .catch(this.handleError);
    }

    /** Log errors that may occur during API calls */
    private handleError(err: HttpErrorResponse) {
        console.log(err.message);
        return Observable.throw(err.message);
    }
}