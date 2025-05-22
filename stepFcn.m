function [NextObs, Reward, IsDone, LoggedSignals] = stepFcn(Action, LoggedSignals, fdt, uLambda, dLambda)
%STEPFCN Make one time step in environment.

%
% This file is part of the archive Code, Data and Results for Numerical
% Experiments in "Context-aware inference for stabilizing dynamical systems
% from scarce data"
% Copyright (C) 2023 Steffen W. R. Werner
% All rights reserved.
% License: BSD 2-Clause License (see COPYING)
%

% Default input values.
if (nargin < 4) || isempty(uLambda)
    uLambda = 1.0e+02;
end

if (nargin < 5) || isempty(dLambda)
    dLambda = 1;
end

% Apply system step.
x = fdt(LoggedSignals.x, double(Action));

% Save time step.
LoggedSignals.t = LoggedSignals.t + 1;

% Save results
LoggedSignals.x = x;
NextObs         = LoggedSignals.x;

for k = 1:size(LoggedSignals.xprev, 2)-1
    LoggedSignals.xprev(:, k) = LoggedSignals.xprev(:, k+1);
end
LoggedSignals.xprev(:, end) = LoggedSignals.x;

% Compute rewards.
[Reward, IsDone] = rewardFcn(LoggedSignals.t, x, LoggedSignals.xprev, ...
    uLambda, dLambda);
