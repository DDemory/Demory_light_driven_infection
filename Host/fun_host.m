function ymod=fun_host(data,theta)

% starting concentrations are at the end of the parameter vector
y0 = theta(end);
%y0 = data.ydata(1,2);
% time is the first column of data.ydata
t  = data.ydata(:,1);

% model integration
[tout,y] = ode45(@fhost_growth,t,y0,[],theta);

ymod = y;
end
