%% fun_PI -- 2019Demory_light
% run the PI (growht vs. Irradiance) model

function ymod=fun_PI(data,theta)

I = 0:0.01:200; % Irradiance 
a = theta(1); % alpha (slope)
Iopt = theta(2); % optimal light 
mu_max = theta(3)-theta(5); % net growth rate
y = mu_max.*(I./(I+(mu_max/a).*((I./Iopt)-1).^2));
ymod = y';

end
