function [params,paramsname,paravec] = setup_para_MCMC(i,para,Hypo,xl,xu,iniH,aveH,stdH,iniV,aveV,stdV)
%% function setup_para define the parameters for the MCMC model from the LHsample

% i = parameter set id from the LHsample to use 
% para = parameter sets to estimate;
% xl = minimum limit of the LHS space and the mcmc constrain
% xu = maximum limit of the LHS space and the mcmc constrain
% Hypo = hypothesis to test: 0 to 7
%	0 = H0
%	1 = H1_\phi
%	2 = H1_\beta
%	3 = H1_\lambda
%	4 = H2_\phi\beta
%	5 = H2_\phi\lambda
%	6 = H2_\lambda\beta
%	7 = H3
% iniH = initial host concentration for the nBatches experiments
% aveH = average of the host initial concentration
% stdH = standard deviation of the host initial concentration
% inIV, aveV and stdV = similar than previously but for virus.

%% Model parameters
% The initial values for S0 and V0 are local to the batches.
% target = what to display for the plots?


if Hypo == 0 %\phi \beta \lambda n=3
    
    LH = para(i,6:end);
    params = {
        % name,           init,  min,   max,  mu,   sig, target?, local?
        {'Adsorption',  LH(1), xl(1), xu(1), LH(1), Inf, 1,       0}
        {'Lysis',       LH(2), xl(3), xu(3), LH(2), sqrt(log(3)), 1,       0}
        {'Burst',       LH(3), xl(5), xu(5), LH(3), sqrt(log(10)), 1,       0}
        {'S0',          iniH,  0,     Inf,   aveH,stdH,0,       1}
        {'V0',          iniV,  0,     Inf,   aveV,stdV,0,       1}
        };
    
    paramsname = {'Adsorption','Lysis', 'Burst'};
    paravec = [LH(1) LH(2) LH(3)];
    
elseif Hypo == 1 %\phi_L \phi_D \beta \lambda n=4
    LH = para(i,7:end);
    params = {
        % name,           init,  min,   max,  mu,   sig, target?, local?
        {'Adsorption L',  LH(1), xl(1), xu(1), NaN, Inf, 1,       0}
        {'Adsorption D',  LH(2), xl(2), xu(2), NaN, Inf, 1,       0}
        {'Lysis',         LH(3), xl(3), xu(3), NaN, sqrt(log(3)), 1,       0}
        {'Burst',         LH(4), xl(5), xu(5), NaN, sqrt(log(10)), 1,       0}
        {'S0',            iniH,  0,     Inf,   aveH,stdH,0,       1}
        {'V0',            iniV,  0,     Inf,   aveV,stdV,0,       1}
        };
    
    paramsname = {'Adsorption_L','Adsorption_D','Lysis', 'Burst'};
    paravec = [LH(1) LH(2) LH(3) LH(4)];
    
elseif Hypo == 2 %\phi \beta_L \beta_D \lambda n=4
    LH = para(i,7:end);
    params = {
        % name,           init,  min,   max,  mu,   sig, target?, local?
        {'Adsorption',    LH(1), xl(1), xu(1), NaN, Inf, 1,       0}
        {'Lysis',         LH(2), xl(3), xu(3), NaN, sqrt(log(3)), 1,       0}
        {'Burst_L',       LH(3), xl(5), xu(5), NaN, sqrt(log(10)), 1,       0}
        {'Burst_D',       LH(4), xl(6), xu(6), NaN, sqrt(log(10)), 1,       0}
        {'S0',            iniH,  0,     Inf,   aveH,stdH,0,       1}
        {'V0',            iniV,  0,     Inf,   aveV,stdV,0,       1}
        };
    
    paramsname = {'Adsorption','Lysis', 'Burst_L', 'Burst_D'};
    paravec = [LH(1) LH(2) LH(3) LH(4)];
    
elseif Hypo == 3 %\phi \beta \lambda_L \lambda_D n=4
    LH = para(i,7:end);
    params = {
        % name,           init,  min,   max,  mu,   sig, target?, local?
        {'Adsorption',    LH(1), xl(1), xu(1), NaN, Inf, 1,       0}
        {'Lysis_L',       LH(2), xl(3), xu(3), NaN, sqrt(log(3)), 1,       0}
        {'Lysis_D',       LH(3), xl(4), xu(4), NaN, sqrt(log(3)), 1,       0}
        {'Burst',         LH(4), xl(5), xu(5), NaN, sqrt(log(10)), 1,       0}
        {'S0',            iniH,  0,     Inf,   aveH,stdH,0,       1}
        {'V0',            iniV,  0,     Inf,   aveV,stdV,0,       1}
        };
    
    paramsname = {'Adsorption','Lysis_L','Lysis_D', 'Burst'};
    paravec = [LH(1) LH(2) LH(3) LH(4)];
    
elseif Hypo == 4 %\phi_L \phi_D \beta_L \beta_D \lambda n=5
    LH = para(i,8:end);
    params = {
        % name,           init,  min,   max,  mu,   sig, target?, local?
        {'Adsorption_L',  LH(1), xl(1), xu(1), NaN, Inf, 1,       0}
        {'Adsorption_D',  LH(2), xl(2), xu(2), NaN, Inf, 1,       0}
        {'Lysis',         LH(3), xl(3), xu(3), NaN, sqrt(log(3)), 1,       0}
        {'Burst_L',       LH(4), xl(5), xu(5), NaN, sqrt(log(10)), 1,       0}
        {'Burst_D',       LH(5), xl(6), xu(6), NaN, sqrt(log(10)), 1,       0}
        {'S0',            iniH,  0,     Inf,   aveH,stdH,0,       1}
        {'V0',            iniV,  0,     Inf,   aveV,stdV,0,       1}
        };
    
    paramsname = {'Adsorption_L','Adsorption_D','Lysis','Burst_L','Burst_D'};
    paravec = [LH(1) LH(2) LH(3) LH(4) LH(5)];
    
elseif Hypo == 5 %\phi_L \phi_D \beta \lambda_L \lambda_D n=5
    LH = para(i,8:end);
    params = {
        % name,           init,  min,   max,  mu,   sig, target?, local?
        {'Adsorption_L',  LH(1), xl(1), xu(1), NaN, Inf, 1,       0}
        {'Adsorption_D',  LH(2), xl(2), xu(2), NaN, Inf, 1,       0}
        {'Lysis_L',       LH(3), xl(3), xu(3), NaN, sqrt(log(3)), 1,       0}
        {'Lysis_D',       LH(4), xl(4), xu(4), NaN, sqrt(log(3)), 1,       0}
        {'Burst',         LH(5), xl(5), xu(5), NaN, sqrt(log(10)), 1,       0}
        {'S0',            iniH,  0,     Inf,   aveH,stdH,0,       1}
        {'V0',            iniV,  0,     Inf,   aveV,stdV,0,       1}
        };
    
    paramsname = {'Adsorption_L','Adsorption_D','Lysis_L','Lysis_D', 'Burst'};
    paravec = [LH(1) LH(2) LH(3) LH(4) LH(5)];
    
elseif Hypo == 6 %\phi \beta_L \beta_D \lambda_L \lambda_D n=5
    LH = para(i,8:end);
    params = {
        % name,           init,  min,   max,  mu,   sig, target?, local?
        {'Adsorption',  LH(1), xl(1), xu(1), NaN, Inf, 1,       0}
        {'Lysis_L',       LH(2), xl(3), xu(3), NaN, sqrt(log(3)), 1,       0}
        {'Lysis_D',       LH(3), xl(4), xu(4), NaN, sqrt(log(3)), 1,       0}
        {'Burst_L',       LH(4), xl(5), xu(5), NaN, sqrt(log(10)), 1,       0}
        {'Burst_D',       LH(5), xl(6), xu(6), NaN, sqrt(log(10)), 1,       0}
        {'S0',            iniH,  0,     Inf,   aveH,stdH,0,       1}
        {'V0',            iniV,  0,     Inf,   aveV,stdV,0,       1}
        };
    
    paramsname = {'Adsorption_L','Lysis_L','Lysis_D', 'Burst_L', 'Burst_D'};
    paravec = [LH(1) LH(2) LH(3) LH(4) LH(5)];
    
elseif Hypo == 7 %\phi_L \phi_D \beta_L \beta_D \lambda_L \lambda_D n=6
    LH = para(i,9:end);
    params = {
        % name,           init,  min,   max,  mu,   sig, target?, local?
        {'Adsorption_L',  LH(1), xl(1), xu(1), NaN, Inf, 1,       0}
        {'Adsorption_D',  LH(2), xl(2), xu(2), NaN, Inf, 1,       0}
        {'Lysis_L',       LH(3), xl(3), xu(3), NaN, sqrt(log(3)), 1,       0}
        {'Lysis_D',       LH(4), xl(4), xu(4), NaN, sqrt(log(3)), 1,       0}
        {'Burst_L',       LH(5), xl(5), xu(5), NaN, sqrt(log(10)), 1,       0}
        {'Burst_D',       LH(6), xl(6), xu(6), NaN, sqrt(log(10)), 1,       0}
        {'S0',            iniH,  0,     Inf,   aveH,stdH,0,       1}
        {'V0',            iniV,  0,     Inf,   aveV,stdV,0,       1}
        };
    
    paramsname = {'Adsorption_L','Adsorption_D','Lysis_L','Lysis_D', 'Burst_L', 'Burst_D'};
    paravec = [LH(1) LH(2) LH(3) LH(4) LH(5) LH(6)];
    
end





