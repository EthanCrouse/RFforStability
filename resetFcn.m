function [InitialObservation, LoggedSignals] = resetFcn(n, xLambda)
%RESETFCN Reset environment to random initial state vector.

%
% This file is part of the archive Code, Data and Results for Numerical
% Experiments in "Context-aware inference for stabilizing dynamical systems
% from scarce data"
% Copyright (C) 2023 Steffen W. R. Werner
% All rights reserved.
% License: BSD 2-Clause License (see COPYING)
%

% Default input values.
if nargin < 2 || isempty(xLambda)
    xLambda = 1;
end

% Reset to random initial state for stabilization task.
LoggedSignals.x = xLambda * randn(n, 1);

% Buffer for collecting signals.
LoggedSignals.xprev         = ones(n, 3);
LoggedSignals.xprev(:, end) = LoggedSignals.x;

% Start at zeroth time discretization point.
LoggedSignals.t    = 0;

% Observations are the same as states.
InitialObservation = LoggedSignals.x;
