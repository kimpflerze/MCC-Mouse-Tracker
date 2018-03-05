import { Component, OnInit } from '@angular/core';
import { QrCodesService } from './qr-codes.service';
import { AppSettings } from '../configuration/AppSettings';

@Component({
  selector: 'app-qr-codes',
  templateUrl: './qr-codes.component.html',
  styleUrls: ['./qr-codes.component.css']
})
export class QrCodesComponent implements OnInit {

  constructor() { }

  ngOnInit() {
  }

  generateQrCodes(color?: string) {
    if(color) {
      window.open(AppSettings.baseUri + "qrcode?color=" + color, "_blank");
    } else {
      window.open(AppSettings.baseUri + "qrcode", "_blank");
    }
  }

}
