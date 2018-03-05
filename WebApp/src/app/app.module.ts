import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AppMaterialModule } from './app-material/app-material.module';

import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NoopAnimationsModule } from '@angular/platform-browser/animations';
import { WelcomeComponent } from './welcome/welcome.component';
import { SettingsComponent } from './settings/settings.component';
import { SettingsService } from './settings/settings.service';
import { OrdersComponent } from './orders/orders.component';
import { OrdersService } from './orders/orders.service';
import { AddOrderComponent } from './add-order/add-order.component';
import { QrCodesComponent } from './qr-codes/qr-codes.component';
import { QrCodesService } from './qr-codes/qr-codes.service';
import { AlertsComponent } from './alerts/alerts.component';
import { AlertsService } from './alerts/alerts.service';
import { StatisticsService } from './statistics/statistics.service';
import { OrderDetailsComponent } from './order-details/order-details.component';
import { ConfirmDialogueComponent } from './confirm-dialogue/confirm-dialogue.component';


@NgModule({
  declarations: [
    AppComponent,
    WelcomeComponent,
    SettingsComponent,
    OrdersComponent,
    AddOrderComponent,
    QrCodesComponent,
    AlertsComponent,
    OrderDetailsComponent,
    ConfirmDialogueComponent
  ],
  entryComponents:[
    AddOrderComponent,
    OrderDetailsComponent,
    ConfirmDialogueComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    FormsModule,
    AppMaterialModule,
    HttpClientModule
  ],
  providers: [
    SettingsService,
    OrdersService,
    QrCodesService,
    AlertsService,
    StatisticsService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
