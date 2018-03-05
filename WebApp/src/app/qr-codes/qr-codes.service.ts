import { Injectable } from "@angular/core";
import { ISettings } from "../models/ISettings";
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/do';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { HttpErrorResponse } from "@angular/common/http/src/response";
import { AppSettings } from "../configuration/AppSettings";
import { IOrder } from "../models/IOrder";

@Injectable()
export class QrCodesService {
    private _getUrl = AppSettings.baseUri + 'qrcode';

    constructor(private _httpClient: HttpClient) {

    }

    getOrders() : void {
        this._httpClient.get(this._getUrl);
    }

    private handleError(err: HttpErrorResponse) {
        console.log(err.message);
        return Observable.throw(err.message);
    }
}