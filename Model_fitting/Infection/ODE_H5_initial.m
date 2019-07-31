% David Demory -- April 2019
function ydot = ODE_H5_initial(t,y,thetalog,para,gversion)
% ode system function for MCMC algae example
% H5 = \phi_L \phi_D \beta \lambda_L \lambda_D
% n para = 5;

S = y(1);
E = y(2);
I = y(3);
V = y(4);
N = S+E+I;

%fixed parameters
L = para(1);
K = para(2);
kd = para(3);
muopt = para(4);
omega = para(5);
deltaL = para(6);
deltaD = para(7);


theta = exp(thetalog);

beta = theta(5);

if gversion == 0
if rem(t,24) < 14 % t = 0 to 14h => light
    
    phi = theta(1);
    lambda = theta(3);
    delta = deltaL;
    
    %omega = omegaL;
    mu = muopt*(L*rem(t,24)).^4./((L*rem(t,24)).^4+kd^4);
    
elseif rem(t,24) >= 14 % t = 14 to 24h => dark
    
    phi = theta(2);
    lambda = theta(4);

    delta = deltaD;
    
    mu = muopt*(L*14).^4./((L*14).^4+kd.^4);
end
elseif gversion == 1
	tau = rem(t,24);
	if tau < 14 % light
	       phi = theta(1);
	       lambda = theta(3);
	       delta = deltaL;
		Lt=tau*L;
		mu = muopt*(Lt^4)/(Lt^4+kd^4);
	else
	       phi = theta(2);
	       lambda = theta(4);
	       delta = deltaD;
		Lt=L*(14-(tau-14)*14/10);
		mu = muopt*(Lt^4)/(Lt^4+kd^4);
	end
end
	


%% model
dotS = mu*S.*(1-N./K) - omega*S - phi*S.*V;
dotE = phi*S.*V - omega*E - 0.5*(1/lambda)*E;
dotI = 0.5*(1/lambda)*E - omega*I - 0.5*(1/lambda)*I;
dotV = beta*0.5*(1/lambda)*I - delta*V - phi*N.*V;

ydot = [dotS;dotE;dotI;dotV];

end


