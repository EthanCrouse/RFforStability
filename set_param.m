clc; clear;

%% Simple Test Matrices
% System Matrices
%{
A = [1.2, 0.3;
    0.4, 0.8];
B = [0.5;
    -0.2];
E = eye(2);
%}

%% Import matrices
mat = load('hf2d5.mat');
A = mat.A;
B = mat.B;
E = mat.E;
C = mat.C;

[W, Ahat, Bhat, Ehat] = compute_feedback(A, B, E);

% System sizes
n = size(A, 1);
m = size(B, 2);

nhat = size(Ahat, 1);
mhat = size(Bhat, 2);

%% Discrete-time parameters and inital values
tau = 0.01;
maxiter = 1000;
iter = 1;
x0 = ones(n, 1);
x = ones(n, maxiter);
x(:,1) = x0;

%% Functions
% E * x(k+1) = A * x(k) + B * u(k)
fdt   = @(x, u) (E - tau * A) \ (E * x + tau * B * u);
 
% Hat fdt
fdtHat   = @(x, u) (Ehat - tau * Ahat) \ (Ehat * x + tau * Bhat * u);


%% RF Param
% Test simulation parameters.
tfinal = 5;
offset = 0;

% Reinforcement learning parameters.
rlTimeSteps = tfinal / tau;
rlEpisodes  = 300;
rlxLambda   = 1;
rluLambda   = 1.0e+02;
rldLambda   = 1;
bias = [0;0];
utest = ones(m, 1);

