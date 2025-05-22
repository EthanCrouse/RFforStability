
%TESTSIMULATION_DT Run discrete test simulations of benchmarks.

%
% This file is part of the archive Code, Data and Results for Numerical
% Experiments in "Context-aware inference for stabilizing dynamical systems
% from scarce data"
% Copyright (C) 2023 Steffen W. R. Werner
% All rights reserved.
% License: BSD 2-Clause License (see COPYING)
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SIMULATE WITH HAT MATRICES                                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maxiter = 1000;
% Set variables for iterating x over the system
x0 = randn(nhat, 1);
x = ones(nhat, maxiter);
x(:,1) = x0;
iter = 1;

% Iterate and use the actor network as the K
while iter < maxiter
    K = cell2mat(getAction(DDPGAgent,  x(:, iter)));
    x(:, iter+1) = fdtHat(x(:,iter), K);
    iter = iter + 1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SIMULATE WITH FULL MATRICES                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set variables for iterating x over the system
x0 = randn(n, 1);
fullx = ones(n, maxiter);
fullx(:,1) = x0;
iter = 1;

% Iterate and use the actor network as the K
while iter < maxiter
    u = cell2mat(getAction(DDPGAgent,  (W'*fullx(:, iter))));
    fullx(:, iter+1) = fdt(fullx(:,iter), u);
    iter = iter + 1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TRAINING DATA                                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

episodeReward = trainStats.EpisodeReward;
numEpisodes = size(episodeReward, 1);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOTTING.                                                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Time vector for plotting
time = (1:maxiter) * tau;


y = C * fullx;
% Plotting
figure;
hold on;
for i = 1:4
    plot(time, y(i, :), 'DisplayName', ['output y_' num2str(i)]);
end
xlabel("time t");
ylabel('Output y(t)'); 
legend('Location', 'southwest');

figure;
plot(time, x, 'DisplayName', ['output y_1']);
xlabel("time t");
ylabel('Output y(t)'); 
legend('Location', 'southwest');
hold off;


figure;
semilogy(1:numEpisodes, episodeReward, 'DisplayName', ['Reward']);
xlabel("Episode");
ylabel('Reward');
title("Episode Reward During Training (HF2D5)");