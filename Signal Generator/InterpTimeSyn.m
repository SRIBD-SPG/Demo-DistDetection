%% 插值法时延接收数据同步 （有问题，需要修改）
% 输入参数
%data  各感知节点接收到的异步数据
%noise  各感知节点所处的背景噪声
%sample_rate   采样率\Hz
%delay  辐射源位置到各感知节点的传输延迟
%NN  信道延迟会对数据进行补零，因此截取数据的一部分进行同步处理
% nfft  插值点数
%输出参数
% data_syn,noise_syn  异步数据经过插值处理后的同步数据
function [data_syn,noise_syn] = InterpTimeSyn(data,noise,sample_rate,delay,NN, nfft)
%       relative_delay = 0;
%       for ii = 2:length(delay)
%           relative_delay = [relative_delay,delay(ii)-delay(1)];
%       end
%       move = relative_delay/(1/sample_rate);
%       
%       
%       move = round(move);
%       data1 = [];
%       noise1 = [];
%       data_tongbu = [];
%       noise_tongbu = [];
%       for t=1:size(data,2)
%           data1(:,t) = data(NN+1:size(data,1),t);
%           noise1(:,t) = noise(NN+1:size(data,1),t);
%           
%           
%           
%           data_tongbu(:,t) = data1((-min(move)+1+move(t)):(size(data,1)-NN-max(move)+move(t)),t);
%           noise_tongbu(:,t) = noise1((-min(move)+1+move(t)):(size(data,1)-NN-max(move)+move(t)),t);
%       end

% move = round((delay - delay(1))*sample_rate);
% Len = length(data(:,1)) - 2*NN;

data_syn = zeros(nfft,size(data,2));
noise_syn = zeros(nfft,size(data,2));

% for t=1:size(data,2)
%     idx = NN + move(t);
%     data_syn(:,t) = data( idx: idx + Len-1, t);
%     noise_syn(:,t) = noise(  idx: idx + Len-1, t);
% end
tplotdw = 1:length(data(:,1));
for t=1:size(data,2)
    t_intp = NN+(delay(t)-delay(1))*sample_rate+[1:nfft];
    signal_dw = data(:,t);

    data_syn(:,t) = interp1(tplotdw, (signal_dw), t_intp,'linear');
%     pp = interp1(tplotdw,(signal_dw),'linear','pp') ;
%     data_syn(:,t)= ppval(pp,t_intp);
    signal_dw = noise(:,t);
%     pp = interp1(tplotdw,(signal_dw),'linear','pp') ;
%     noise_syn(:,t)= ppval(pp,t_intp);
    noise_syn(:,t) = interp1(tplotdw, (signal_dw), t_intp,'linear');

end


end