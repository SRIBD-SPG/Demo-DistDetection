%% 调制信号经信道传输
% 输入参数
%samp_rate  number (120k) 采样率\Hz   标量（120k）
%Modulated_singnal 矢量 （长度为观测时间/采样率 0.5s/120k=60000） 调制信号  矢量
%snr  矢量（长度为感知节点个数）感知节点处的接收信噪比 \dB
%tau  矢量（长度为感知节点个数）辐射源位置到各感知节点的传输延迟 \s
%alpha  矢量(长度为感知节点个数) 代表每个节点的噪声水平 
%输出参数
%data 矢量 （长度60000） 感知节点接收到信号
%noise 矢量  （长度60000）感知节点所处的背景噪声 （高斯噪声）
% H 信道参数  矢量 （单辐射源 每个元素都是相同复数的向量）
function  [data,noise,H] = channelTrans(fc, samp_rate,Modulated_signal,snr,tao,alpha)
        channel = helperModClassTestChannel(...
         'SampleRate', samp_rate, ...
         'SNR', 0, ...
         'ALPHA',0,...
         'PathDelays', 0, ...
         'KFactor', 4, ...
         'AveragePathGains', 0, ...
         'MaximumDopplerShift', 0, ...
         'MaximumClockOffset', 0, ...
         'PathGainsOutputPort',1,...
         'CenterFrequency',fc);
        for t=1:length(snr)
            channel.SNR = snr(t);
            channel.PathDelays = tao(t);
            channel.ALPHA = alpha(t);
            [data(:,t),noise(:,t),H(:,t)] = channel(Modulated_signal);
%             data(:,t)=Low_fileter(Para_Stru,data(:,t));
%             noise(:,t)=Low_fileter(Para_Stru,noise(:,t));
            release(channel)
        end
end

