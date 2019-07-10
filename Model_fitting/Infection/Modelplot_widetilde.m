% David Demory -- April 2019
function  [t,y] = Modelplot_widetilde(data,theta)

% starting concentrations are at the end of the parameter vector
data.ydata
y0 = [data.ydata(1,2),0,0,data.ydata(1,3)];
t  = data.ydata(1,1):0.01:140;

para = [data.L,data.K,data.kd,data.muopt,data.omega,data.deltaL,data.deltaD];

options = odeset;
%options = odeset('Reltol',1E-8, 'AbsTol',1E-8);

if data.Hypo == 0
    [tout,y] = ode45(@ODE_H0_widetilde,t,y0,options,theta,para);
elseif data.Hypo == 1
    [tout,y] = ode45(@ODE_H1_widetilde,t,y0,options,theta,para);
elseif data.Hypo == 2
    [tout,y] = ode45(@ODE_H2_widetilde,t,y0,options,theta,para);
elseif data.Hypo == 3
    [tout,y] = ode45(@ODE_H3_widetilde,t,y0,options,theta,para);
elseif data.Hypo == 4
    [tout,y] = ode45(@ODE_H4_widetilde,t,y0,options,theta,para);
elseif data.Hypo == 5
    [tout,y] = ode45(@ODE_H5_widetilde,t,y0,options,theta,para);
elseif data.Hypo == 6
    [tout,y] = ode45(@ODE_H6_widetilde,t,y0,options,theta,para);
elseif data.Hypo == 7
    [tout,y] = ode45(@ODE_H7_widetilde,t,y0,options,theta,para);
end


end
