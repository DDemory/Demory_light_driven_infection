
% Parameter verification
figure(1)
mcmcplot(chain,[],results,'chainpanel');

figure(2)
mcmcplot(chain,[],results,'denspanel');

% Fits verification
figure(3)
t = 0:0.01:34;

    para = median(res.chain);
    [tout,y] = ode45(@fhost_growth,t,para(end),[],para);
    plot(t,y,'-','Color',[0.8 0.8 0.8])
    
hold on
plot(data.ydata(2:end,1),data.ydata(2:end,2),'o','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',7.5)
hold off