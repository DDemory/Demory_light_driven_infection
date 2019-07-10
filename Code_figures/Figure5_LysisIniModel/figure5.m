 %% figure5 -- 2019Demory_light
% plot the Lysis Inhibition model fits for 5000 mcmc chains.
% this code use some MCMC toolbox functions. Copyright (c) 2017, Marko Laine.

%% setup
% environment
clear all; close all; clc;

% figure
figure('DefaultAxesFontSize',20,'DefaultAxesFontName','Times')
set(gcf,'units','centimeters','position',[0 0 35.8 33.9])
set(gcf,'color','w')
set(groot,{'DefaultAxesXColor','DefaultAxesYColor','DefaultAxesZColor'},{'k','k','k'})

% subplot id
p_HM2_MED4_host = [1,5,9,13,17];
p_HM2_MED4_virus = [2,6,10,14,18];
p_SSP7_MED4_host = [3,7,11,15,19];
p_SSP7_MED4_virus = [4,8,12,16,20];

%% Plot

% What to plot?
for s = 1:8
    
    % P-HM2 -- lysis inhibition model -- H1 -- host
    if s == 1
        k = 1; % host k == 1, virus k == 2
        load('out_Strain_0_H1_delayLysis_1.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2; % median
        np = nn-1;
        dimcH = [102 178 255]/255;
        dimcV = dimcH;
        lineS = '-';
        
        % P-HM2 -- initial model -- H0 -- host
    elseif s == 2
        k = 1;
        load('out_Strain_0_H0_delayLysis_0.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2; % median
        np = nn-1;
        dimcH = [100 100 100]/255;
        dimcV = dimcH;
        lineS = '-';
        
        % P-HM2 -- lysis inhibition model -- H1 -- virus
    elseif s == 3
        k = 2;
        load('out_Strain_0_H1_delayLysis_1.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2; % median
        np = nn-1;
        dimcH = [102 178 255]/255;
        dimcV = dimcH;
        lineS = '-';
        
        % P-HM2 -- initial model -- H0 -- virus
    elseif s == 4
        k = 2;
        load('out_Strain_0_H0_delayLysis_0.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2; % median
        np = nn-1;
        dimcH = [100 100 100]/255;
        dimcV = dimcH;
        lineS = '-';
        
        % P-SSP7 -- lysis inhibition model -- H0 -- host
    elseif s == 5
        k = 1;
        load('out_Strain_1_H0_delayLysis_1.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2; % median
        np = nn-1;
        dimcH = [208,28,139]/255;
        dimcV = dimcH;
        lineS = '-';
        
        % P-SSP7 -- initial model -- H0 -- host
    elseif s == 6
        k = 1;
        load('out_Strain_1_H0_delayLysis_0.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2; % median
        np = nn-1;
        dimcH = [100 100 100]/255;
        dimcV = dimcH;
        lineS = '-';
        
        % P-SSP7 -- lysis inhibtion -- H0 -- virus
    elseif s == 7
        k = 2;
        load('out_Strain_1_H0_delayLysis_1.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2; % median
        np = nn-1;
        dimcH = [208,28,139]/255;
        dimcV = dimcH;
        lineS = '-';
        
        % P-SSP7 -- initial model -- H0 -- virus
    elseif s == 8
        k = 2;
        load('out_Strain_1_H0_delayLysis_0.mat')
        np = size(out.predlims{1}{1},1);
        nn = (np+1)/2; % median
        np = nn-1;
        dimcH = [100 100 100]/255;
        dimcV = dimcH;
        lineS = '-';
    end
    
    
    
    % Treatments == viral inoculotion times
    % b == 1, 14.5h
    % b == 2, 18h
    % b == 3, 24.5h
    % b == 4, 30h
    % b == 5, 36h
    for b = 1:5
        
        
        plimi = out.predlims{b};
        ny = size(plimi,2);
        
        time = out.data{b}.ydata(:,1);
        
        if s < 5
            dataH = xlsread('dataHM2_raw_host.xlsx',b);
            dataV = xlsread('dataHM2_raw_virus.xlsx',b);
        else
            dataH = xlsread('dataSSP7_raw_host.xlsx',b);
            dataV = xlsread('dataSSP7_raw_virus.xlsx',b);
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
        
        
        % subplot identification
        if s <= 2
            Hv = p_HM2_MED4_host;
        elseif s == 3 || s == 4
            Hv = p_HM2_MED4_virus;
        elseif s == 5 || s == 6;
            Hv = p_SSP7_MED4_host;
        elseif s == 7 || s == 8;
            Hv = p_SSP7_MED4_virus;
        end
        
        hAx(Hv(b)) = subplot(5,4,Hv(b));
        
        % shaded area
        ff(s) = fillyy(time,plimi{k}(1,:),plimi{k}(2*nn-1,:),dimcV);
        ff(s).FaceAlpha = 0.4;
        hold on
        
        % median fit
        plot(time,plimi{k}(nn,:),'-','linewidth',1.5,'linestyle',lineS,'color',dimcV);
        set(gca,'Yscale','log')
        drawnow
        
        % add data+std and light/dark cycles
        if s == 2 | s == 4 | s == 6 | s == 8;
            %err = errorbar(datai(:,1),datai(:,k+1),datai(:,k+3),'k.','LineStyle','none');
            dd1 = plot(tdata,rep1,'^','MarkerSize',5,'MarkerFaceColor','black','MarkerEdgeColor','black');
            dd2 = plot(tdata,rep2,'.','MarkerSize',20,'MarkerFaceColor','black','MarkerEdgeColor','black');
            vv = vfill([14 24; 38 48; 62 72; 86 96; 110 120; 134 144],'gray','facealpha',0.2,'EdgeColor','none');
            %uistack(err,'bottom');
            uistack(dd1,'bottom');
            uistack(dd2,'bottom');
            uistack(vv,'bottom');
        end
        
        % plot info labeling
        if k == 2
            ylim([1E5 1E11])
            xlim([0 140])
            set(gca, 'XTick',[0 20 40 60 80 100 120 140])
            set(gca, 'YTick',[1E5 1E7 1E9 1E11])
        elseif k == 1
            ylim([1E7 1E9])
            xlim([0 140])
            set(gca, 'XTick',[0 20 40 60 80 100 120 140])
            set(gca, 'YTick',[1E7 1E8 1E9])
        end
        
       
        
        set(gca,'TickDir','out')
        set(gca,'box','off')
        
        if b == 5
            set(gca,'xticklabels',{'0','','40','','80','','120',''})
        else
            set(gca,'xticklabels','')
        end
        
         
        if b == 3 && k == 1
            ylabel('Cell/mL','Interpreter','Tex')
        elseif b == 3 && k == 2
            ylabel('Virus/mL','Interpreter','Tex')
        elseif b == 5  && k == 2 && s == 5
            xlabel('Time (hours)')
        end
        
        
    end
    
    
end

% clean some yaxis bugs
set(hAx(17),'YTick',[1E7 1E8 1E9],'YTickLabels',{'10^7','10^8','10^9'})
set(hAx(19),'YTick',[1E7 1E8 1E9],'YTickLabels',{'10^7','10^8','10^9'})              

% legend
h1 =  legend(hAx(1),[ff(2),ff(1)],'model $H0$','model $\widetilde{H1_{\phi}}$','interpreter','latex','orientation','horizontal','location','southoutside');
h2 =  legend(hAx(3),[ff(7),dd1,dd2],'$\widetilde{H0}$','replicate 1','replicate 2','interpreter','latex','orientation','horizontal','location','southoutside');
h1.Box = 'off'; h2.Box = 'off';
h1.Position = [0.12    0.05   0.2266    0.0307];
h2.Position = [0.143    0.01   0.2266    0.0307];


% axes labels
p1=get(hAx(1),'position'); 
p2=get(hAx(20),'position'); 
hAxOuter=axes('position',[p1(1) p2(2) p2(1)+p2(3)-p1(1)  p1(2)+p1(4)-p2(2)], ...
              'color','none','visible','off'); % an outer axis for the whole figure
%Xlabel    
hY=text(0.5,-0.05,'Time (hours)','rotation',0,'fontsize',20, ... 
        'horizontalalignment','center','verticalalignment','top');

%% Export
print -dpng -r600 figure5.png
%print -dpdf -r600 -painters figure5.pdf
%print -depsc2 -tiff -r600 -painters figure5.eps

