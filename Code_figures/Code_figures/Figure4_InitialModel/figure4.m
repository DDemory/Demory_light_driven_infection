%% figure4 -- 2019Demory_light
% plot the initial model dynamics for the viral inoculation time 14.5 hours post
% infection.
% this code use some MCMC toolbox functions. Copyright (c) 2017, Marko Laine.

%% Setup 

% environment
clear all; close all; clc;

% figure
figure('DefaultAxesFontSize',20,'DefaultAxesFontName','Times')
set(gcf,'units','centimeters','position',[0 0 40 10])
%set(gcf,'units','centimeters','position',[0 0 100 24])
set(gcf,'color','w')
set(groot,{'DefaultAxesXColor','DefaultAxesYColor','DefaultAxesZColor'},{'k','k','k'})


%% Dynamics plots
for s = 1:8
    
    % What to plot?
    % P-HM2 -- initial model -- model H2_{\phi \lambda} -- host dynamics
    if s == 1
        k = 1; % 1 == host, 2 == virus
        load('out_Strain_0_H5_delayLysis_0.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2;
        np = nn-1;
        dimcH = [65,174,118]/255;
        dimcV = dimcH;
        lineS = '-';
        
        % P-HM2 -- initial model -- model H0 -- host dynanics
    elseif s == 2
        k = 1;
        load('out_Strain_0_H0_delayLysis_0.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2;
        np = nn-1;
        dimcH = [100 100 100]/255;
        dimcV = dimcH;
        lineS = '-';
        
        % P-HM2 -- initial model -- model H2_{\phi \lambda} -- virus dynamics
    elseif s == 3
        k = 2;
        load('out_Strain_0_H5_delayLysis_0.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2;
        np = nn-1;
        dimcH = [65,174,118]/255;
        dimcV = dimcH;
        lineS = '-';
        
        % P-HM2 -- initial model -- model H0 -- virus dynamics
    elseif s == 4
        k = 2;
        load('out_Strain_0_H0_delayLysis_0.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2; % median
        np = nn-1;
        dimcH = [100 100 100]/255;
        dimcV = dimcH;
        lineS = '-';
        
        % P-SSP7 -- initial model -- H0 -- host dynamics
    elseif s == 5
        k = 1;
        load('out_Strain_1_H0_delayLysis_0.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2; % median
        np = nn-1;
        dimcH = [100 100 100]/255;
        dimcV = dimcH;
        lineS = '-';
        
        % P-SSP7 -- initial model -- H2_{\beta} -- host dynamics
    elseif s == 6
        k = 1;
        load('out_Strain_1_H1_delayLysis_0.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2; % median
        np = nn-1;
        dimcH = [254,153,41]/255;
        dimcV = dimcH;
        lineS = '-';
        
        % P-SSP7 -- initial model -- H0 -- virus dynamics
    elseif s == 7
        k = 2;
        load('out_Strain_1_H0_delayLysis_0.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2; % median
        np = nn-1;
        dimcH = [100 100 100]/255;
        dimcV = dimcH;
        lineS = '-';
        
        % P-SSP7 -- initial model -- H2_{\beta} -- virus dynamics
    elseif s == 8
        k = 2;
        load('out_Strain_1_H1_delayLysis_0.mat')
        np = size(out.predlims{1}{1},1);
        %np = 5;
        nn = (np+1)/2; % median
        np = nn-1;
        dimcH = [254,153,41]/255;
        dimcV = dimcH;
        lineS = '-';
    end
    
    % plot dynamics according to mcmc results
    plimi = out.predlims{1};
    ny = size(plimi,2);
    
    time = out.data{1}.ydata(:,1);
    
    if s < 5
        dataH = xlsread('PHM2_ZT145.xlsx',1);
        dataV = xlsread('PHM2_ZT145.xlsx',2);
    else
        dataH = xlsread('PSSP7_ZT145.xlsx',1);
        dataV = xlsread('PSSP7_ZT145.xlsx',2);
    end
    
   if k == 1;
       tdata = dataH(:,1);
       rep1 = dataH(:,2);
       rep2 = dataH(:,3);
   else
       tdata = dataV(:,1);
       rep1 = dataV(:,2);
       rep2 = dataV(:,3);
   end

    
    % subplot locations
    if s <= 2
        Hv = 1;
    elseif s == 3 || s == 4
        Hv = 2;
    elseif s == 5 || s == 6
        Hv = 3;
    elseif s == 7 || s == 8
        Hv = 4;
    end
    
    hAx(Hv) = subplot(1,4,Hv);
    hold on
    
    ff(s) = fillyy(time,plimi{k}(1,:),plimi{k}(2*nn-1,:),dimcV); % quantiles (fillyy function from the MCMC toolbox -- https://mjlaine.github.io/mcmcstat/)
    ff(s).FaceAlpha = 0.4;
    
    mm = plot(time,plimi{k}(nn,:),'-','linewidth',1.5,'linestyle',lineS,'color',dimcV); % median
    set(gca,'Yscale','log')
    
    % can comment this line to speedup the code.
    drawnow
  
    
    % add data and light-darl cycles gray lines
    if s == 2 | s == 4 | s == 6 | s == 8
        dd1 = plot(tdata,rep1,'^','MarkerSize',5,'MarkerFaceColor','black','MarkerEdgeColor','black');
        dd2 = plot(tdata,rep2,'.','MarkerSize',20,'MarkerFaceColor','black','MarkerEdgeColor','black');
        vv = vfill([14 24; 38 48; 62 72; 86 96; 110 120; 134 144],'gray','facealpha',0.2,'EdgeColor','none'); %vfill function from Chade Greene package (https://www.mathworks.com/matlabcentral/fileexchange/43090-hfill-and-vfill) 
        uistack(dd1,'bottom');
        uistack(dd2,'bottom');
        uistack(vv,'bottom');
    end
    
    if k == 2
        ylim([1E5 1E11])
        xlim([0 140])
        set(gca, 'XTick',[0 20 40 60 80 100 120 140])
        set(gca, 'YTick',[1E5 1E7 1E9 1E11])
        ylabel('Virus/mL','Interpreter','Tex')
        
    elseif k == 1
        ylim([1E7 1E9])
        xlim([0 140])
        set(gca, 'XTick',[0 20 40 60 80 100 120 140])
        set(gca, 'YTick',[1E7 1E8 1E9])
        ylabel('Cell/mL','Interpreter','Tex')
    end
    
    
    set(gca,'TickDir','out')
    set(gca,'box','off')
    set(gca,'xticklabels',{'0','','40','','80','','120',''})
   
    
end

% legend
%h1 =  legend(hAx(1),[ff(2),ff(1)],'model $H0$','model $H2_{\phi \lambda}$','interpreter','latex','orientation','horizontal','location','southoutside');
%h2 =  legend(hAx(3),[ff(6),dd1,dd2],'model $H1_{\phi}$','replicate 1','replicate 2','interpreter','latex','orientation','horizontal','location','southoutside');
%h1.Box = 'off'; h2.Box = 'off';
%h1.Position = [0.1,0.01,0.1807,0.0485];
%h2.Position = [0.215,0.01,0.1807,0.0485];

% axes labels
%p1=get(hAx(1),'position'); 
%p2=get(hAx(4),'position'); 
%hAxOuter=axes('position',[p1(1) p2(2) p2(1)+p2(3)-p1(1)  p1(2)+p1(4)-p2(2)], ...
%              'color','none','visible','off'); % an outer axis for the whole figure
%Xlabel    
%hY=text(0.5,-0.05,'Time (hours)','rotation',0,'fontsize',20, ... 
%        'horizontalalignment','center','verticalalignment','top');
    
%% Export

print -dpng -r600 figure4.png
%print -dpdf -r600 -painters figure4.pdf
%print -depsc2 -tiff -r600 -painters figure4.eps

