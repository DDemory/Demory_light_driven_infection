function err=host_obj_fun(theta,data)

% omit nans
%nanID = isnan(data.ydata(:,2)); % nans may occur in y
%tdata  = data.ydata(~nanID,1); % t
%ydata  = data.ydata(~nanID,2); % y
ydata = data.ydata(:,2);

% run the model with the parameter set theta.
ymodel = fun_host(data,theta);
%ymodel = ymodel(~nanID);

% error 
objfun = (1/nansum(length(ydata)))*nansum(log(ymodel./ydata).^2);
err = objfun;

end
