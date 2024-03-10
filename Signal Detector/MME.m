function  statistics = MME(X)
% Maximum-Minimum Eigenvalue (MME) Detector
% Reference: https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=5089517
%
% Input Arguments:
% X - a n-by-p complex matrix, each row represents a sample of p variables with overall n samples 
%
% Output Arguments:
% statistics - the obtained test statistics via the MME detector
% 
% Example:
% p = 5;
% n = 100;
% X = complex(randn(n, p), randn(n, p));
% disp(MME(X));
%
% Author: Rui Zhou
% Email: rui.zhou@sribd.cn
%

% compute sample covariance matrix (SCM)
n = size(X, 1);
S = 1/n * X' * X;

% extract eigenvalues of SCM
[~, D] = eig(S);
d = real(diag(D));

% compute statistics
statistics = max(d) / min(d);
end
