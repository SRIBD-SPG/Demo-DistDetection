function statistics = CAV(X)
% Covariance Absolute Value (CAV) Detector
% Reference: https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=4610972
%
% Input Arguments:
% X - a n-by-p complex matrix, each row represents a sample of p variables with overall n samples 
%
% Output Arguments:
% statistics - the obtained test statistics via the CAV detector
% 
% Example:
% p = 5;
% n = 100;
% X = complex(randn(n, p), randn(n, p));
% disp(CAV(X));
%
% Author: Rui Zhou
% Email: rui.zhou@sribd.cn
%

% compute sample covariance matrix (SCM)
[n, p] = size(X);
S = 1/n * X' * X;

% calculate off-diagonal elements on diagonal elements ratio
statistics = sum(sum(abs(S))) / mean(diag(abs(S)));

end
