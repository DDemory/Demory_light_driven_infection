%% fun_growth -- 2019Demory_light
% ODE of the growth model (host without virus)

function dy = fhost_growth(t,x,para)

%% parameters
% PI curve para
a = para(1); % alpha (slop)
Iopt = para(2); % optimal growth
mu_max = para(3); % max growth rate

% host dynamic parameters
kd = para(4); % Minimum amount of light necessary to divide
m = para(5);
I = 35; % irrdaince during the experiment
mu_opt = mu_max.*(I./(I+(mu_max/a).*((I./Iopt)-1).^2)); % optimal growth 

% calcul of the growth depending on the light or dark condition
if rem(t,24) < 14 % light
    mu = mu_opt*(I*rem(t,24))^4/((I*rem(t,24))^4+kd^4);
elseif rem(t,24) > 14 % dark
    mu = mu_opt*(I*14).^4/((I*14).^4+kd.^4);
end


%% ODE
dy = (mu-m)*x;

end

