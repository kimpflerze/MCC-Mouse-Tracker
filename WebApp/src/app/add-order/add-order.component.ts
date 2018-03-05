import { Component, OnInit } from '@angular/core';
import { IOrder } from '../models/IOrder';
import { NgForm } from '@angular/forms';
import { OrdersService } from '../orders/orders.service';

@Component({
  selector: 'app-add-order',
  templateUrl: './add-order.component.html',
  styleUrls: ['./add-order.component.css']
})
export class AddOrderComponent implements OnInit {

  /** The new Order to Add */
  model = new IOrder();

  /**
   * @constructor
   * @param _ordersService The OrdersService used to interact with the Orders API 
   */
  constructor(private _ordersService: OrdersService) { }

  ngOnInit() {
  }

  /** Adds a new order based on the values provided to the form */
  submit() {
    this._ordersService.postOrder(this.model)
    .subscribe(result => console.log(result));
  }

}
