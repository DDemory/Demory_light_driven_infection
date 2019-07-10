%% mcmcplot_host -- 2019Demory_light
% Function modified from the mcmc toolbox for matlab. 
% plot the host dynamics for the nn mcmc results.
% Copyright (c) 2017, Marko Laine


function h= mcmcplot_host(out,data,adddata,dimc)
% initial help from the mcmc toolbox: MCMCPREDPLOT - predictive plot for mcmc results
% Creates predictive figures for each batch in the data set using
% mcmc chain. Needs input from the function mcmcpred.
% Example:
%  out=mcmcpred(results,chain,s2chain,data,modelfun);
%  mcmcpredplot(out)
%
% If s2chain has been given to mcmcpred, then the plot shows 95%
% probability limits for new observations and for model parameter
% uncertainty. If s2chain is not used then the plot contains 50%,
% 90%, 95%, and 99% predictive probability limits due parameter uncertainty.

% $Revision: 1.5 $  $Date: 2013/04/17 08:45:40 $

if nargin < 2
    data = out.data;
end

if nargin < 3
    adddata = 0; % add data.ydata datapoints to the figures
end

nbatch = length(out.predlims); % nbr of treatments.

if ~iscell(data)
    d=data; data=[]; data{1}=d; clear d
end

np = size(out.predlims{1}{1},1);
nn = (np+1)/2; % median
np = nn-1;

hh = zeros(nbatch,1);

for i=1:nbatch
    if nbatch > 1;  
    end; % create new figures
    
    plimi = out.predlims{i};
    ny = size(plimi,2);
    
    datai = data{i};
    
    if isnumeric(datai)
        time = datai(:,1); % time is the first columd of data
    elseif isfield(datai,'ydata')
        time = datai.ydata(:,1); % first column of ydata
    elseif isfield(datai,'xdata')
        time = datai.xdata(:,1); % first column of xdata
    else
        error('dont know the x axis of the plots')
    end
    
    for j=1:ny
        
        if ny>1;;end
        if ~isempty(out.obslims)
            fillyy(time,out.obslims{i}{j}(1,:),out.obslims{i}{j}(3,:),dimc);
            hold on
        end
        fillyy(time,plimi{j}(1,:),plimi{j}(2*nn-1,:),dimc);
        hold on

        for k=2:(nn-1)
            fillyy(time,plimi{j}(k,:),plimi{j}(2*nn-k,:),dimc.*0.85.^(k-1));
        end
        
       dimf = dimc+0.4*dimc;
       dimf(dimf>1)=1;
       
        plot(time,plimi{j}(nn,:),'-','linewidth',3,'color',dimf);
        if adddata
            %errorbar(datai.ydata(2:end,1), datai.ydata(2:end,j+1),datai.ydata(2:end,j+2),'ok','LineStyle','none','MarkerSize',10,'MarkerFaceColor','k')
            plot(datai.ydata(:,1),datai.ydata(:,2),'ok','LineStyle','none','MarkerSize',10,'MarkerFaceColor','k')
            plot(datai.ydata(:,1),datai.ydata(:,3),'sk','LineStyle','none','MarkerSize',10,'MarkerFaceColor','k')
        end
        hold off
        
    end
    
end

if nargout > 0
    h=hh;
end
