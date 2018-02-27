import { Injectable } from "@angular/core";
import { ISettings } from "../models/ISettings";
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/do';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { HttpErrorResponse } from "@angular/common/http/src/response";
import { AppSettings } from "../configuration/AppSettings";
import { IStatistics } from "../models/IStatistics";

@Injectable()
export class StatisticsService {

    /** URL used for retrieving the current statistics from the Statistics API */
    private _getCurrentUrl = AppSettings.baseUri + 'statistics/current';

    /**
     * @constructor
     * @param _httpClient An HttpClient used for making calls to the Statistics API
     */
    constructor(private _httpClient: HttpClient) { }

    /** Gets the current statistics */
    getCurrentStatistics() : Observable<IStatistics> {
        return this._httpClient.get<IStatistics>(this._getCurrentUrl)
            .do(data => console.log('All: ' + JSON.stringify(data)))
            .catch(this.handleError);
    }

    /** Logs error that occur during API calls */
    private handleError(err: HttpErrorResponse) {
        console.log(err.message);
        return Observable.throw(err.message);
    }
}