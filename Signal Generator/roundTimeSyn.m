%% 根据采样率以及辐射源位置到感知节点时延进行时延补偿，按照四舍五入计算需移动的采样点个数，实现各感知节点接收数据大致同步
% 输入参数
% data  各感知节点接收到的数据
%noise  各感知节点所处的背景噪声
% sample_rate  采样率\Hz
%delay  辐射源位置到各感知节点的传输延迟
% NN  信道延迟会对数据进行补零，因此截取数据的一部分进行同步处理
%输出参数
%data_syn   noise_syn  经过同步处理后的各感知节点的数据
%  move  各感知节点数据需移动的采样点数以粗略达到时间同步
function [data_syn,noise_syn,move] = roundTimeSyn(data,noise,sample_rate,delay,NN)
move = round((delay )*sample_rate); % - delay(1)
Len = length(data(:,1)) - 2*NN;

data_syn = zeros(Len,size(data,2));
noise_syn = zeros(Len,size(data,2));

for t=1:size(data,2)
    idx = NN + move(t);
    data_syn(:,t) = data( idx: idx + Len-1, t);
    noise_syn(:,t) = noise(  idx: idx + Len-1, t);
end


end