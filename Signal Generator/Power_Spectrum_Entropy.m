%%  求解功率谱熵
function [Pxx,fw,Hw_x]=Power_Spectrum_Entropy(Smat,Para_Stru)
window = hamming(Para_Stru.M);
noverlap = 0.5*Para_Stru.M;%数据重叠
[Pxx,fw]=pwelch(Smat,window,noverlap,Para_Stru.nfft,Para_Stru.Fs);%[]
End_point=floor(length(Pxx)*(Para_Stru.Rb+0.5e3)/(Para_Stru.Fs/2));% 
Pxx=Pxx(1:End_point);
fw=fw(1:End_point);



%计算概率
for i = 1:length(Pxx)
    p_x(i)=Pxx(i)/sum(Pxx);
end

%计算功率谱熵
Hw_x=-sum(p_x.*(log2(p_x)));
end
