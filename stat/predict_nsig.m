function [Y,YCI] = predict_nsig(mdl,Xnew,n)
%PREDICT_NSIG is a wrapper for "predict.m" (predictor for response of 
%   linear regression model), where the confidence interval is decided in
%   standard deviation (sigma) units.
%
%   [Y,YCI] = predict_nsig(mdl,Xnew,n)
%
%   n is the number of sigmas to represent the confidence interval. default
%   is 1.
%
%   NOTE: options for calling predict is set to:
%       'Prediction'    to  'curve'
%       'Simultaneous'  to  'true'
%
% DKS 2019

% 1-sigma confidence interval for prediction
if nargin==2
    n = 1;
end

pred_conf_lvl = erf(n/sqrt(2));    % confidence level
pred_alpha = 1-pred_conf_lvl;               % alpha: 100(1 – alpha)

% [Y,YCI] = predict(mdl,Xnew,'Alpha',pred_alpha,'Prediction','observation','Simultaneous',true);
[Y,YCI] = predict(mdl,Xnew,'Alpha',pred_alpha,'Prediction','curve','Simultaneous',true);

end