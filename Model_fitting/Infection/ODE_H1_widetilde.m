% David Demory -- April 2019
function ydot = ODE_H1_widetilde(t,y,thetalog,para)
% ode system function for SEIV model
% H1 = \phi_L \phi_D \beta \lambda
% n para = 4;

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

lambda = theta(3);
beta = theta(4);

if rem(t,24) < 14 % t = 0 to 14h => light
    
    phi = theta(1);
    delta = deltaL;
    
    %omega = omegaL;
    mu = muopt*(L*rem(t,24)).^4./((L*rem(t,24)).^4+kd^4);
    
elseif rem(t,24) >= 14 % t = 14 to 24h => dark
    
    phi = theta(2);
    delta = deltaD;
    
    mu = muopt*(L*14).^4./((L*14).^4+kd.^4);
end


%% model
dotS = mu*S.*(1-N./K) - omega*S - phi*S.*V;
dotE = phi*S.*V - omega*E - 0.5*(1/lambda)*E + phi*V.*I;
dotI = 0.5*(1/lambda)*E - omega*I - 0.5*(1/lambda)*I - phi*V.*I;
dotV = beta*0.5*(1/lambda)*I - delta*V - phi*N.*V;

ydot = [dotS;dotE;dotI;dotV];

end


