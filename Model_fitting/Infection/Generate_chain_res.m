function out = Generate_chain_res(Strain,Hypo,delayLysis,nn)

gversion = 1;
nbrBatches = 5;

%clear all;close all;clc;
disp('running ...')

%% function definition
if delayLysis == 0
    fun = @Modelfun_initial;
elseif delayLysis == 1
    fun = @Modelfun_widetilde;
end

%% Load Data
[data,iniH,aveH,stdH,iniV,aveV,stdV,xl_a,xu_a] = setup_strain(Strain,Hypo,delayLysis,gversion,nbrBatches);
dataplot = data;
dataplot{1}.ydata = datamerge(dataplot{1}.ydata,(14.5:(134-14.5)/(12000-27):134)');
dataplot{2}.ydata = datamerge(dataplot{2}.ydata,(18:(134-18)/(12000-25):134)');
dataplot{3}.ydata = datamerge(dataplot{3}.ydata,(24.5:(134-24.5)/(12000-22):134)');
dataplot{4}.ydata = datamerge(dataplot{4}.ydata,(30:(134-30)/(12000-19):134)');
dataplot{5}.ydata = datamerge(dataplot{5}.ydata,(36:(134-36)/(12000-15.5):134)');

%% Load MCMC results
directory = './Results/';
name = [directory,'MCMCres_H',num2str(Hypo),'_Strain_',num2str(Strain),'_delayLysis_',num2str(delayLysis)];
load([name,'.mat']);

%% Out
if Strain == 0
	id = 2;
	out = mcmcpred_modif(resmcmc{id}.results,resmcmc{id}.chain,resmcmc{id}.s2chain,dataplot,fun,nn);
elseif Strain == 1
	id = 4;
	out = mcmcpred_modif(resmcmc{id}.results,resmcmc{id}.chain,resmcmc{id}.s2chain,dataplot,fun,nn);
end

%% Save
directory_save = './Results_Chains/';
save([directory_save,'out_Strain_',num2str(Strain)','_H',num2str(Hypo),'_delayLysis_',num2str(delayLysis),'.mat'],'out');
disp('done!');
end