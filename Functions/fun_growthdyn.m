%% fun_PI -- 2019Demory_light
% run the PI (growht vs. Irradiance) model

function mu_net = fun_growthdyn(data,theta)

t = 0:0.01:48;
I = 35;

% Calcul of L
for i = 1:length(t),
    
    tau = rem(t(i),24); % Light-dark time
    if tau < 14
        L(i) = tau*I;
    else
        L(i) = I*(14-(tau-14)*14/10);
    end
end

% Calcul of mu

a = theta(1);
Iopt = theta(2);
mu_max = theta(3);
Kd = theta(4);
omega = theta(5);
mu_opt = mu_max.*(I./(I+(mu_max/a).*((I./Iopt)-1).^2));

mu_net = (mu_opt-omega)*((L.^4)./(L.^4+Kd^4));
mu_net = mu_net';

end
