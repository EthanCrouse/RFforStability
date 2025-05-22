%% Get Stability Feedback Control
function [W, Ahat, Bhat, Ehat] = compute_feedback(A, B, E)

    % Compute dominant eigenvalues and eigenvectors
    [V, D] = eigs(A', E', 3, 'largestreal');
    eigenvalues = diag(D);
    index = eigenvalues > 0;
    D
   
    
    % Basis of unstable space
    W = V(:, index);

    % Reduced system matrices
    Ahat = W' * A * W;
    Bhat = W' * B;
    Ehat = W' * E * W;
end