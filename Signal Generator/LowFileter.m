%% 低通滤波器
%输入参数
% Pare_Stru  调制信号的参数设置
%Signal_Modu  感知节点接收到的信号
%输出参数
%Signal_LPF  经过低通滤波器的信号
function [Signal_LPF]=LowFileter(Para_Stru,Signal_Modu)

Wp=(2*Para_Stru.Rb-0.5e3)/(Para_Stru.Fs/2);                                                             % 通带截止频率
Ws=(2*Para_Stru.Rb+0.5e3)/(Para_Stru.Fs/2);                                                          % 阻带起始频率
[N ,wn]=buttord(Wp,Ws,2*Para_Stru.Rp,Para_Stru.Rs); %巴特沃斯滤波器设置
[ b,a ] = butter(N,wn);
Signal_LPF=filter(b,a,Signal_Modu); 



% figure;
% N=length(Signal_LPF);
% a=abs(fftshift(fft(Signal_LPF)));
% f = (-N/2:N/2-1)*Para_Stru.Fs/N;
% plot(f,a);


end