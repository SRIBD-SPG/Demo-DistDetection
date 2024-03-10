function  statistics = AGM(X)
% The Arithmetic to Geometric Mean (AGM) Detector
% Reference: https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=5397901
%
% Input Arguments:
% X - a n-by-p complex matrix, each row represents a sample of p variables with overall n samples 
%
% Output Arguments:
% statistics - the obtained test statistics via the AGM detector
% 
% Example:
% p = 5;
% n = 100;
% X = complex(randn(n, p), randn(n, p));
% disp(AGM(X));
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
statistics = mean(d) / geo_mean(d);
end
