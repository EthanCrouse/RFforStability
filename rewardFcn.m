function [Reward, IsDone] = rewardFcn(t, x, xprev, uLambda, dLambda)
%REWARDFCN Compute current reward for given time step.

%
% This file is part of the archive Code, Data and Results for Numerical
% Experiments in "Context-aware inference for stabilizing dynamical systems
% from scarce data"
% Copyright (C) 2023 Steffen W. R. Werner
% All rights reserved.
% License: BSD 2-Clause License (see COPYING)
%

% End episode if norm of x is too large.
IsDone = (t > 1) ...
    && ((norm(x) > (uLambda * sqrt(length(x)))) ...
    || any(isnan(x)));

% Compute rewards.
xCost      = x' * x;
scaleConst = 1.0e+02;
numSteps   = 0.5 * t * (t + 1);

if IsDone
    % Extra negative reward, if destabilizing.
    Reward = -scaleConst * xCost * sqrt(length(x)) / (dLambda * numSteps);
elseif (t > 20) ...
        && (norm(xprev, 2) < sqrt(length(x)) * 1.0e-02)
    % Extra positive reward, if early stabilizing.
    IsDone = true;
    Reward = -scaleConst * xCost * sqrt(length(x)) * uLambda * numSteps;
else
    % Classical LQG reward.
    % Reward = -xCost - Action' * Action;
    
    % Only penalize large (unstable) states.
    Reward = -xCost;
end