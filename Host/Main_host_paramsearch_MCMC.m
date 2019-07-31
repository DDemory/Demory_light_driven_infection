%% Parameter estimation with the MCMC metropolis algorithm
% from the MCMC toolbox for the host growth model without viruses infection
% David Demory Jul 2018
% need the MCMC toolbox functions to run this code
% (https://mjlaine.github.io/mcmcstat/)

clear all;close all;clc;

%addpath('~/Dropbox (GaTech)/MATLAB_fct/')

nRunMCMC = 50; %number of MCMC alogirhtms run
% Import data
data.ydata = xlsread('./Data/dataMED4.xlsx',1);

%% Model options
% Set some parameters for the run.
method      = 'dram'; % adaptation method, 'mh', 'dr', 'am', or 'dram'
nsimu       = 10000;   % number of simulations
adaptint    = 500;    % how often to adapt the proposal
model.N = 16;         % nbr of data points      
model.ssfun         = @host_obj_fun;      % error function
options.method      = method;   % adaptation method (mh,am,dr,dram)
%options.adaptint    = adaptint; % adaptation interval
%options.printint    = 200;      % how often to show info on acceptance ratios
%options.verbosity   = 1;        % how much to show output in Matlab window
options.waitbar     = 0;        % show garphical waitbar
options.updatesigma = 1;        % update error variance
options.stats       = 1;        % save extra statistics in results
%options.adascale    = 400;
%model.S20 = sqrt(3.8964e+07);
%model.N0 = 1;


%theta = [0.0003,35,0.02625,140,0.01,data.ydata(2,2)];
%host_obj_fun(theta,data)




% Constrained to be positif but no constrains on the max limit.
% limit used in the paper are from [Moore and Chisholm 1999]
% params = name, initial value, min limit, max limit, mean, std, target, local
% for more information check the MCMC toolbox help.
params = {
    {'alpha', 0.00058333 , 0.0001, 0.002 NaN, Inf, 1, 0} %std calculated from Moore et al 1999
    {'Iopt', 45, 15, 80, NaN, Inf, 1, 0} %std calculated from Moore et al 1999
    {'mu_max', 0.02625, 0.015, 0.045, NaN, Inf, 1, 0} %std calculated from Moore et al 1999
    {'kd', 322, 0, 1000, NaN, Inf, 1, 0}
    {'m', 0.01, 0, 0.1, NaN, Inf, 1, 0}
    {'P0', data.ydata(2,2),0, Inf, NaN, Inf, 1, 0}
    };

% params = {
%     {'alpha', 0.00058333 , 0.0001, 0.002 0.00058333, sqrt(4.1667e-05), 1, 0} %std calculated from Moore et al 1999
%     {'Iopt', 46, 15, 80, 45, sqrt(7), 1, 0} %std calculated from Moore et al 1999
%     {'mu_max', 0.02, 0.015, 0.045, 0.02625, sqrt(0.0025), 1, 0} %std calculated from Moore et al 1999
%     {'kd', 300, 0}
%     {'m', 0.01, 0}
%     {'P0', data.ydata(2,2),0}
%     };

% params = {
%     {'alpha', 0.00058333 , 0.0001, Inf, 0.00058333, sqrt(4.1667e-05), 1, 0} %std calculated from Moore et al 1999
%     {'Iopt', 46, 15, Inf, 45, sqrt(7), 1, 0} %std calculated from Moore et al 1999
%     {'mu_max', 0.02, 0.015, Inf, 0.02625, sqrt(0.0025), 1, 0} %std calculated from Moore et al 1999
%     {'kd', 300, 0}
%     {'m', 0.01, 0}
%     {'P0', data.ydata(2,2),0}
%     };

% params = {
%     {'alpha', 0.0003 , 0, 0.002} %std calculated from Moore et al 1999
%     {'Iopt', 35, 0, 100} %std calculated from Moore et al 1999
%     {'mu_max', 0.02625, 0, 0.05} %std calculated from Moore et al 1999
%     {'kd', 140, 0}
%     {'m', 0.01, 0}
%     {'P0', data.ydata(2,2),0}
%     };


% Burnin MCMC run
results = [];
options.nsimu = 5000;

disp('Run 0 ********************')
[results,chain,s2chain,sschain]=mcmcrun(model,data,params,options,results);
disp(['error = ',num2str(sschain(end))])
disp(['rejection rate = ',num2str(results.rejected)])

% update distributions mean and std
  %for z = 1:5
  %    params{z}{5} = mean(chain(:,z));
      %params{z}{6} = std(chain(:,z));
  %end
%     
    
mcmcplot(chain,[],results,'chainpanel');  
drawnow
% param search
options.nsimu = nsimu;

for x = 1:nRunMCMC
%    while results.rejected >= 0.25
    disp(['------------ n ',num2str(x),' ------------']);
    
    % update distributions mean and std
    %for z = 1:5
    %    params{z}{5} = mean(chain(:,z));
    %    params{z}{6} = std(chain(:,z));
    %end
    
    [results,chain,s2chain,sschain]=mcmcrun(model,data,params,options,results);
    disp(['error = ',num2str(sschain(end))])
    disp(['rejection rate = ',num2str(results.rejected)])
    
    res.results = results;
    res.chain = chain;
    res.s2chain = s2chain;
    res.sschain = sschain;
    
    mcmcplot(chain,[],results,'chainpanel');  
    drawnow 
    
end

%save('./MCMC_results/MED4_mcmcres.mat','res');
%MCMC_plot_verification
