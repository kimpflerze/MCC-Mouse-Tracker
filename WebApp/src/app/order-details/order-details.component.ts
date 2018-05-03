import { Component, OnInit, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA, MatDialog } from '@angular/material';
import { IOrder } from '../models/IOrder';
import { OrdersService } from '../orders/orders.service';
import { ConfirmDialogueComponent } from '../confirm-dialogue/confirm-dialogue.component';

@Component({
  selector: 'app-order-details',
  templateUrl: './order-details.component.html',
  styleUrls: ['./order-details.component.css']
})
export class OrderDetailsComponent implements OnInit {

  /**
   * The order represented by this instance of OrderDetailsComponent
   */
  public order: IOrder;

  /**
   * A MatDialog used for user confirmation
   */
  private confirmDialogRef: MatDialogRef<ConfirmDialogueComponent>;

  /**
   * @constructor 
   * @param dialogRef A reference to this MatDialog
   * @param data The data passed into the dialog 
   * @param _ordersService An OrdersService to interact with the Orders API
   * @param _confirmDialogue A MatDialog used for confirmation
   */
  constructor(public dialogRef: MatDialogRef<OrderDetailsComponent>,
    @Inject(MAT_DIALOG_DATA) public data: IOrder, 
    public _ordersService: OrdersService,
    public _confirmDialogue: MatDialog) { }

  /**
   * Initializes the component
   */  
  ngOnInit() {
    this.order = this.data;
  }

  /**
   * Saves changes to the 'charged' property of the given order.
   * @param id The Id of the order.
   * @param value The value of the 'charged' checkbox ("Yes" or "No").
   */
  saveChanges(id: string, value: string) {
    let intValue = value == "Yes" ? 1 : 0;
    this._ordersService.updateCharged(id, intValue)
      .subscribe(() => this.dialogRef.close());
  }

  /**
   * Opens a confirmation dialog, which, if confirmed, marks a given alert as 'inactive'.
   * @param id The Id of the order to be deactivated.
   */
  removeOrder(id: string) {
    this.confirmDialogRef = this._confirmDialogue.open(ConfirmDialogueComponent, {
      height: '200px',
      width: '400px',
      data: "Are you sure you want to remove this order?"
    });
    let result: boolean;
    this.confirmDialogRef.afterClosed().subscribe(x => {
      if(x == true) {
        this._ordersService.updateActive(id, 0)
          .subscribe(() => this.dialogRef.close());
      }
     });  
  }

}
