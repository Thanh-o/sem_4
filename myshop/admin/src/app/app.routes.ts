import { Routes } from '@angular/router';
import { LoginComponent } from './auth/login/login.component';
import { RegisterComponent } from './auth/register/register.component';
import { DashboardComponent } from './page/dashboard/dashboard.component';
import { AuthGuard } from './auth.guard'; // Import AuthGuard
import { UserComponent } from './page/user/user.component';

export const routes: Routes = [
  { path: '', component: DashboardComponent, canActivate: [AuthGuard] }, // Bảo vệ route Dashboard
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'users', component: UserComponent, canActivate: [AuthGuard]},
  { path: '**', redirectTo: '' }
];
