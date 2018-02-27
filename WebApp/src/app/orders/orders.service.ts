import { Injectable } from "@angular/core";
import { ISettings } from "../models/ISettings";
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/do';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { HttpErrorResponse } from "@angular/common/http/src/response";
import { AppSettings } from "../configuration/AppSettings";
import { IOrder } from "../models/IOrder";
import { patch } from "webdriver-js-extender";

@Injectable()
export class OrdersService {

    /** The URL to use for GET Calls */
    private _getUrl = AppSettings.baseUri + 'order?active=1&&orderByDate=asc';

    /** The URL to use for POST Calls */
    private _postUrl = AppSettings.baseUri + 'order';

    /**
     * @constructor
     * @param _httpClient An HttpClient to interact with the Orders API
     */
    constructor(private _httpClient: HttpClient) {
    }

    /** Gets all active Orders  */
    getOrders() : Observable<IOrder[]> {
        return this._httpClient.get<IOrder[]>(this._getUrl);
    }

    /** Logs errors that may occur during API Calls */
    private handleError(err: HttpErrorResponse) {
        console.log(err.message);
        return Observable.throw(err.message);
    }

    /** 
     * Adds a new Order 
     * @param model The Order to add
     */
    postOrder(model : IOrder): Observable<IOrder> {
        return this._httpClient.post(this._postUrl, model, 
        {
            headers: new HttpHeaders().set('Content-Type', 'application/json')
        }).catch(this.handleError);    
    }

    /** 
     * Updates the 'Charged' property of an order 
     * @param id The Id of the order to update
     * @param value The new value of the 'Charged' property (0 or 1)
     */
    updateCharged(id: string, value: number) {
        return this._httpClient.patch(this.buildPatchUrl(id, "charged", value), null);
    }

    /**
     * Updates the 'Active' property of an order
     * @param id The Id of the Order to update
     * @param value The new value of the 'Active' property (0 or 1)
     */
    updateActive(id: string, value: number) {
        return this._httpClient.patch(this.buildPatchUrl(id, "active", value), null);
    }

    /**
     * Constructs the URL for a PATCH call to the Orders API
     * @param id The Id of the Order
     * @param property The Property to patch
     * @param value The new value of the property
     */
    private buildPatchUrl(id: string, property: string, value: number): string {
        return AppSettings.baseUri + `order/${id}?${property}=${value}`; 
    }
}