%% Parameter estimation with the MCMC metropolis algorithm
% from the MCMC toolbox for the host growth model without viruses infection
% David Demory Jul 2018
% need the MCMC toolbox functions to run this code
% (https://mjlaine.github.io/mcmcstat/)

clear all;close all;clc;

%addpath('~/Dropbox (GaTech)/MATLAB_fct/')

nRunMCMC = 3; %number of MCMC alogirhtms run
% Import data
data.ydata = xlsread('./Data/dataMED4.xlsx',1);


%% Model options
% Set some parameters for the run.
method      = 'dram'; % adaptation method, 'mh', 'dr', 'am', or 'dram'
nsimu       = 5000;   % number of simulations
adaptint    = 500;    % how often to adapt the proposal
model.N = 16;         % nbr of data points      
model.ssfun         = @host_obj_fun;      % error function
options.method      = method;   % adaptation method (mh,am,dr,dram)
options.adaptint    = adaptint; % adaptation interval
options.printint    = 200;      % how often to show info on acceptance ratios
options.verbosity   = 1;        % how much to show output in Matlab window
options.waitbar     = 1;        % show garphical waitbar
options.updatesigma = 1;        % update error variance
options.stats       = 1;        % save extra statistics in results

% Constrained to be positif but no constrains on the max limit.
% limit used in the paper are from [Moore and Chisholm 1999]
% params = name, initial value, min limit, max limit, mean, std, target, local
% for more information check the MCMC toolbox help.
params = {
    {'alpha', 0.6E-3 , 0, Inf NaN, Inf, 1, 0}
    {'Iopt', 45, 0, Inf, NaN, Inf, 1, 0}
    {'mu_max', 0.055, 0, Inf, NaN, Inf, 1, 0}
    {'kd', 320, 0, Inf, NaN, Inf, 1, 0}
    {'m', 0.02, 0, Inf, NaN, Inf, 1, 0}
    {'P0', data.ydata(1,2),0, Inf, NaN, Inf, 1, 0}
    };

% Burnin MCMC run
results = [];
options.nsimu = 1000;

disp('Run 0 ********************')
[results,chain,s2chain,sschain]=mcmcrun(model,data,params,options,results);
disp(['error = ',num2str(sschain(end))])
disp(['rejection rate = ',num2str(results.rejected)])

% param search
options.nsimu = nsimu;

for x = 1:nRunMCMC
    
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
    
end

save('./MCMC_results/MED4_mcmcres.mat','res');
MCMC_plot_verification
