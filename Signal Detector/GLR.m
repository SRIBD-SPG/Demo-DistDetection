function  statistics = GLR(X, r, noise_power_range)
% Generalized Likelihood Ratio (GLR) Detector
% Reference: https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=5755211
%
% Input Arguments:
% X - a n-by-p complex matrix, each row represents a sample of p variables with overall n samples 
% r - an integer, as the constrainted rank, i.e., number of independent
%     signal sources.
% noise_power_range: a two-dimensional numeric vector, as the noise power range. 
%                    If set to be negative, noise power will be unconstrainted.
%
% Output Arguments:
% statistics - the obtained test statistics via the AGM detector
% 
% Example:
% p = 5;
% n = 100;
% X = complex(randn(n, p), randn(n, p));
% disp(GLR(X, 1, -1));
%
% Author: Rui Zhou
% Email: rui.zhou@sribd.cn
%

% check if 'GLRT-Utility' folder is added
if exist('FAD', 'file') ~= 2
    addpath('GLRT-Utilities\');
    disp('Add Utility Functions For GLRT Detector.');
end

% compute sample covariance matrix (SCM)
n = size(X, 1);
S = 1/n * X' * X;

% MLE decomposition
max_iter = 1e2;
ptol = 1e-6;
ftol = 1e-6;

% estimated Sigma (low-rank plus diagonal) under H1
[H, Sgm,~] = FAD(S, r, noise_power_range, max_iter, ptol, ftol);
H1_M = H*H'+Sgm;

% estimated Sigma (diagonal) under H0
H0_N = diag(diag(S));

% compute statistics: (log-likelihood under H1) - (log-likelihood under H0)
statistics = real((trace(H0_N\S)-trace(H1_M\S)+log(det(H0_N))-log(det(H1_M))));
end
