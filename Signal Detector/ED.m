function  statistics = ED(X)
% Energy Detector (ED)
% Reference: https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=1447503
%
% Input Arguments:
% X - a n-by-p complex matrix, each row represents a sample of p variables with overall n samples
%
% Output Arguments:
% statistics - the obtained test statistics via the ED detector
%
% Example:
% p = 5;
% n = 100;
% X = complex(randn(n, p), randn(n, p));
% disp(ED(X));
%
% Author: Rui Zhou
% Email: rui.zhou@sribd.cn
%

% calculate the energy of X
statistics = norm(X, 'fro')^2;
end