import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { WelcomeComponent } from './welcome/welcome.component';
import { SettingsComponent } from './settings/settings.component';
import { OrdersComponent } from './orders/orders.component';
import { AddOrderComponent } from './add-order/add-order.component';
import { QrCodesComponent } from './qr-codes/qr-codes.component';
import { AlertsComponent } from './alerts/alerts.component';

const routes: Routes = [
  { path: 'settings', component: SettingsComponent},
  { path: 'dashboard', component: WelcomeComponent },
  { path: 'orders', component: OrdersComponent},
  { path: 'alerts', component: AlertsComponent},
  { path: '', component: WelcomeComponent}
]

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
