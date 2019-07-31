function res = LHS_explore(s,Hypo,delayLysis,gversion,nS)

%% Parameter estimation with the MCMC metropolis algorithm
% from the MCMC toolbox for the SEIV model applied to the Qinglu dataset
% David Demory -- April 2019

nbrBatches = 5;

[data,iniH,aveH,stdH,iniV,aveV,stdV,LHsample,xl_a,xu_a,npara] = setup_strain_LHS(s,nS,Hypo,delayLysis,gversion,nbrBatches);
para = [data{1}.L,data{1}.K,data{1}.kd,data{1}.muopt,data{1}.omega,data{1}.deltaL,data{1}.deltaD];

%% EXPLORE LHS

    
    results = [];
    err = [];
    disp(['Strain ',num2str(s),' -- Hypo H',num2str(Hypo),' -- delayLysis ',num2str(delayLysis)])
    
    for i = 1:nS

        [params,paramsname,paravec] = setup_para(i,LHsample,xl_a,xu_a,Hypo,iniH,aveH,stdH,iniV,aveV,stdV);
        
        err = Qinglu_Obj_ini(paravec,data);
        disp(['i = ',num2str(i),' -- error = ',num2str(err)])
        
        TAB = [];
        
    res{i}.para = exp(paravec);
    res{i}.logpara = paravec;
    res{i}.err = err;


    
end


directory = './LHS_results/';
save([directory,'ini_err_space_H',num2str(Hypo),'_Strain_',num2str(s),'_delayLysis_',num2str(delayLysis)],'res')

end

