import { Component, OnInit, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';

@Component({
  selector: 'app-confirm-dialogue',
  templateUrl: './confirm-dialogue.component.html',
  styleUrls: ['./confirm-dialogue.component.css']
})
export class ConfirmDialogueComponent implements OnInit {

  /**
   * The message passed into the dialog
   */
  confirmationMessage: string;

  /**
   * @constructor
   * @param dialogRef A reference to this MatDialog
   * @param data The data passed into the Dialog
   */
  constructor(public dialogRef: MatDialogRef<ConfirmDialogueComponent>,
    @Inject(MAT_DIALOG_DATA) public data: string) { }

  ngOnInit() {
    this.confirmationMessage = this.data;
  }

  /**
   * Close the Dialog with a value of "True"
   */
  confirm() {
    this.dialogRef.close(true);
  }

  /**
   * Close the Dialog with a value of "False"
   */
  cancel() {
    this.dialogRef.close(false);
  }

}
