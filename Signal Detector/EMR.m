function  statistics = EMR(X)
% Eigenvalue-Moment-Ratio (EMR) Detector
% Reference: https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=6905846
%
% Input Arguments:
% X - a n-by-p complex matrix, each row represents a sample of p variables with overall n samples 
%
% Output Arguments:
% statistics - the obtained test statistics via the EMR detector
% 
% Example:
% p = 5;
% n = 100;
% X = complex(randn(n, p), randn(n, p));
% disp(EMR(X));
%
% Author: Rui Zhou
% Email: rui.zhou@sribd.cn
%

% compute sample covariance matrix (SCM)
[n, p] = size(X);
S = 1/n * X' * X;

% extract moments from SCM
M1 = 1/p * real(trace(S));
M2 = 1/p * norm(S, 'fro')^2;

% compute statistics
statistics = M2 / (M1^2);

end
