%参数修改模块
function [Para_Stru]=Parameter
Para_Stru.Signal_Time=0.1;%总时长
Para_Stru.Per_Signal_Time=0.1;%每次检测时长
Para_Stru.window_num=Para_Stru.Signal_Time/Para_Stru.Per_Signal_Time;%10 
Para_Stru.Fc=1.45e9;%载频
Para_Stru.Fs=600e3;%采样率
Para_Stru.Rb=20e3;%码元速率
Para_Stru.zero=Para_Stru.Fs/Para_Stru.Rb;%过采样率
Para_Stru.LenData=Para_Stru.Signal_Time*Para_Stru.Fs;%总采样点数
Para_Stru.Symbol_Num=Para_Stru.LenData/Para_Stru.zero;%码元个数
Para_Stru.FFT_Number=1024;%fft点数
% Para_Stru.Nd=30;%welch方法的分段数
Para_Stru.Mc_Number=10;%试验次数
% Para_Stru.SNR=[-15];%输入信噪比
% Para_Stru.SNR=[-20 -19 -18 -17 -16 -15];%输入信噪比
Para_Stru.SNR= -15;%输入信噪比
Para_Stru.beta=7;%输入β值
Para_Stru.Noise_variance=1;%噪声方差
Para_Stru.M=512;%功率谱窗长
Para_Stru.Pf=0.01;
Para_Stru.Pf_H=0.1;
Para_Stru.Pf_L=0.01;
Para_Stru.nfft=1024;%功率谱点数
Para_Stru.initial_snr=-18;
Para_Stru.Rp=4;           %低通 通带纹波系数
Para_Stru.Rs=20;          % 阻带衰减系数
%多节点参数
Para_Stru.max_iter = 1000;
Para_Stru.ptol = 1e-6;
Para_Stru.ftol = 1e-6;
Para_Stru.MonteCarlo=600;
Para_Stru.node_number=1;
Para_Stru.node2_max_taoer=33e-6;
% Para_Stru.node2_move_number=ceil(Para_Stru.node2_max_taoer*Para_Stru.Fs);
Para_Stru.node2_move_number=2;
Para_Stru.node3_move_number=1;
Pare_Stru.B=0;%x<=Para_Stru.node2_move_number
% Para_Stru.L = Para_Stru.Signal_Time*Para_Stru.Fs;
end