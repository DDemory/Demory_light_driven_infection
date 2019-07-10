%% fun_growth -- 2019Demory_light
%% Run the ODE model for the Host Growth

function ymod=fun(data,theta)

% starting concentrations are at the end of the parameter vector
y0 = theta(end);

% time is the first column of data.ydata
t  = data.ydata(:,1);
[tout,y] = ode45(@fhost_growth,t,y0,[],theta);

ymod = y;
end
