%%  各感知节点接收数据生成
% 输入参数
%modu_type string  调制方式选择 modulationTypes = categorical(["BPSK", "QPSK", "8PSK", ...
%  "16QAM", "64QAM", "PAM4", "GFSK", "CPFSK", ...
%  "B-FM", "DSB-AM", "SSB-AM"]);  
%baund_rate number (20k)  波特率\baund
%samp_rate  number (120k) 采样率\Hz
%observe_time number (0.5s)  观测时间\s
%tau  矢量（长度为感知节点个数） 传输延迟\s
%snr  矢量（长度为感知节点个数） 感知节点处接收信噪比\dB
%alpha  矢量(长度为感知节点个数) 代表每个节点的噪声水平 
% fc   载频
% 输出参数
% allNodeData（struct）  感知节点处接收的数据 包含背景噪声
function allNodeDataASyn = nodeDataGene(fc, modu_type,baud_rate,samp_rate,observe_time,tau,snr,alpha)
       dataSrc = helperModClassGetSource(modu_type, samp_rate/baud_rate, observe_time*samp_rate,samp_rate);
       modulator = helperModClassGetModulator(modu_type,samp_rate/baud_rate, samp_rate);
       baseband_signal = dataSrc();
       Modulated_signal = modulator(baseband_signal);
%        tau = zeros(1,length(snr));
%        snr = zeros(1,length(snr));

       [data_asyn,noise_asyn,h] = channelTrans(fc, samp_rate,Modulated_signal,snr,tau,alpha);
%        datas = data_asyn - noise_asyn;
%        datas(:,1)./h(:,1)
%        h(4,1)./h(4,2)
%        datas(:,1)./Modulated_signal/ h(4,1)
%        NStart=1000;
%        L=observe_time*samp_rate;
%        nfft = 2^(nextpow2(L)-1);
%        CompType='Round';%%%%  'Round'  'Interp'  'Freq'
%        [data_syn,noise_syn,~] = compensateSignals(data_asyn,noise_asyn,samp_rate,tau,NStart, nfft, CompType);
       allNodeDataASyn = struct();
       allNodeDataASyn.signal = data_asyn;
       allNodeDataASyn.noise = noise_asyn;
       allNodeDataASyn.h = h;
%        i = 2;
% (allNodeDataASyn.signal(:,i) - allNodeDataASyn.noise(:,i))./Modulated_signal./allNodeDataASyn.h(:,i)
% (datas(1:100,i))./Modulated_signal(1:100,:)./h(1:100,i)
end