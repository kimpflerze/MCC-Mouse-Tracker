import { Component, OnInit } from '@angular/core';
import { MatTableDataSource, MatDialog } from '@angular/material'
import { OrdersService } from './orders.service';
import { IOrder } from '../models/IOrder';
import { AddOrderComponent } from '../add-order/add-order.component';
import { OrderDetailsComponent } from '../order-details/order-details.component';

@Component({
  selector: 'app-orders',
  templateUrl: './orders.component.html',
  styleUrls: ['./orders.component.css']
})
export class OrdersComponent implements OnInit {

  /**
   * The columns displayed in the data table
   */
  displayedColumns = ['Lab', 'Protocol', 'DeliveryDate', 'MaleMice', 'FemaleMice', 'Charged', 'Button'];
  
  /**
   * The data source for the data table
   */
  dataSource: MatTableDataSource<IOrder>;

  /**
   * A list of all active orders
   */
  orders: IOrder[];
  
  /**
   * @constructor
   * @param _ordersService An OrdersService for interacting with the Orders API
   * @param _dialog A MatDialog used for both the AddOrder Dialog and the OrderDetailsDialog
   */
  constructor(private _ordersService: OrdersService, private _dialog: MatDialog) 
  {
    this._dialog.afterAllClosed.subscribe(() => this.getOrders());
  }

  ngOnInit() {
    this.getOrders(); 
  }

  /** Retrieves the active Orders from the Orders API */
  getOrders() : void {
    this._ordersService.getOrders()
    .subscribe(
        orders => { this.orders = orders; }, 
        null, 
        () => this.dataSource = new MatTableDataSource(this.orders)
    ); 
  }

  /** Opens the AddOrder Dialog */
  addOrderClick(): void {
    this._dialog.open(AddOrderComponent);
  }

  /** Opens the OrderDetails Dialog  */
  orderDetailClick(order: IOrder): void {
    this._dialog.open(OrderDetailsComponent, {
      height: '400px',
      width: '600px',
      data: order
    });
  }
}
