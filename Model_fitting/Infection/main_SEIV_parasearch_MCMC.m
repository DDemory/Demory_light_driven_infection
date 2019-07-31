% David Demory -- April 2019
function [data,resmcmc] = main_SEIV_parasearch_MCMC(s,Hypo,delayLysis,gversion,nsimu,nRun)

%% Parameter estimation with the MCMC metropolis algorithm
% from the MCMC toolbox for the SEIV model
% MCMC toolbox (mcmcstat) is needed to run this script (https://mjlaine.github.io/mcmcstat/)


% s = viral strains: P-HM2 (0) or P-SSP7 (1)
% Hypo = Hypothesis to test
% delayLysis = Initial model (0) or lysis inhibition model (1)
% nsimu = length of the mcmc chains
% nRun = number of mcmc run


%% Setup the strains
nbrBatches = 5;
[data,iniH,aveH,stdH,iniV,aveV,stdV,xl_a,xu_a] = setup_strain(s,Hypo,delayLysis,gversion,nbrBatches);
para = [data{1}.L,data{1}.K,data{1}.kd,data{1}.muopt,data{1}.omega,data{1}.deltaL,data{1}.deltaD];
directory_ini = './LHS_results/';

%% Model options
% Set MCMC parameters for the run.
method      = 'dram'; % adaptation method, 'mh', 'dr', 'am', or 'dram'
adaptint    = 100;    % adaptation interval
model.ssfun = @SEIV_Obj_fun;
options.method      = method;        % adaptation method (mh,am,dr,dram)
options.nsimu       = nsimu;         % n:o of simulations
options.adaptint    = adaptint; % adaptation interval
options.printint    = 200; % how often to show info on acceptance ratios
options.verbosity   = 1;  % how much to show output in Matlab window
options.waitbar     = 1;  % show garphical waitbar
options.updatesigma = 1;  % update error variance
options.stats       = 1;  % save extra statistics in results

% Load the initial parameter set (from LHS results)
load([directory_ini,'ini_err_space_H',num2str(Hypo),'_Strain_',num2str(s),'_delayLysis_',num2str(delayLysis),'.mat']);
% calculate the best LHS runs
temp = [];
for i = 1:length(res)
    temp = [temp;[i,res{i}.err,res{i}.para,res{i}.logpara]];
end

local = sortrows(temp,2);
% 10 first best results
MAT = local(1:10,:);
% best result
%MAT = local(1,:);

if MAT == 1;
    
    resmcmc = [];
    return
    
else
    
   disp([num2str(size(MAT,1)),' parameter sets found to be relevant'])
    
    %% MCMC run
    
    for k = 1:size(MAT,1)
        
        MAT(k,:)
        
        results = [];
        [params,paramsname,paravec] = setup_para_MCMC(k,MAT,Hypo,xl_a,xu_a,iniH,aveH,stdH,iniV,aveV,stdV);
        
        
        disp('#################################################')
        disp(['loop ',num2str(k),'/',num2str(size(MAT,1)),' -- Strain ',num2str(s),' -- Hypo H',num2str(Hypo),' -- delayLysis ',num2str(delayLysis)])
        disp(['Error ini = ',num2str(MAT(k,2))])
        disp('#################################################')
        
        TAB = array2table(exp(paravec));
        TAB.Properties.VariableNames = paramsname;
        TAB
        
        
        for j = 1:nRun
            
            disp(['Run ',num2str(j),' ***************************'])
            [results,chain,s2chain,sschain]=mcmcrun(model,data,params,options,results);
            disp(['error = ',num2str(median(sschain))])
            disp(['rejection rate = ',num2str(results.rejected)])
            
            TAB = array2table(exp(median(chain)));
            TAB.Properties.VariableNames = paramsname;
            TAB
        end
        
        resmcmc{k}.results = results;
        resmcmc{k}.chain = chain;
        resmcmc{k}.s2chain = s2chain;
        resmcmc{k}.sschain = sschain;
        
    end
    
    %% save
    if MAT ~= 1
        directory_save = './Results/';
        save([directory_save,'MCMCres_H',num2str(Hypo),'_Strain_',num2str(s),'_delayLysis_',num2str(delayLysis)],'resmcmc')
    end
    
    %% Plot chain
    plot_mcmc
    
end


end



