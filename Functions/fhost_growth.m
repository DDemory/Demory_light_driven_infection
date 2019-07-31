%% fun_growth -- 2019Demory_light
% ODE of the growth model (host without virus)

function dy = fhost_growth(t,x,para)

%% parameters
% PI curve para
a = para(1); % alpha (slop)
Iopt = para(2); % optimal growth
mu_max = para(3); % max growth rate

% host dynamic parameters
Kd = para(4); % Minimum amount of light necessary to divide
m = para(5);
I = 35; % irrdaince during the experiment
mu_opt = mu_max.*(I./(I+(mu_max/a).*((I./Iopt)-1).^2)); % optimal growth 

% calcul of the growth depending on the light or dark condition
tau = rem(t,24);
if tau < 14 % light
	L=tau*I;
	mu = mu_opt*(L^4)/(L^4+Kd^4);
else
	L=I*(14-(tau-14)*14/10);
	mu = mu_opt*(L^4)/(L^4+Kd^4);
end




%% ODE
dy = (mu-m)*x;

end

