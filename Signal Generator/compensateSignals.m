function [data_syn,noise_syn,move] = compensateSignals(data,noise,sample_rate,delay,NN, nfft, comptype)
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

move = round((delay - delay(1))*sample_rate);
% Len = length(data(:,1)) - 2*NN;
data_syn = zeros(nfft,size(data,2));
noise_syn = zeros(nfft,size(data,2));

% for t=1:size(data,2)
%     idx = NN + move(t);
%     data_syn(:,t) = data( idx: idx + Len-1, t);
%     noise_syn(:,t) = noise(  idx: idx + Len-1, t);
% end
% delay = delay - delay(1);
% move = round((delay)*sample_rate);

for t=1:size(data,2)
    switch comptype
        case 'Round'
            t_intp = NN + round((delay(t))*sample_rate) + [1:nfft]; %delay(t)-delay(1)
            data_syn(:,t) = data(t_intp,t);
            noise_syn(:,t) = noise(t_intp,t);

        case 'Interp'
            tplotdw = 1:length(data(:,1));
            t_intp = NN + ((delay(t))*sample_rate)+[1:nfft]; %delay(t)-delay(1)
            signal_dw = data(:,t);
            data_syn(:,t) = interp1(tplotdw, (signal_dw), t_intp,'linear');
            signal_dw = noise(:,t);
            noise_syn(:,t) = interp1(tplotdw, (signal_dw), t_intp,'linear');

        case 'Freq'
            tmpc = ceil((delay(t))*sample_rate) - (delay(t))*sample_rate;
            t_intp = NN + ceil((delay(t))*sample_rate) + [1:nfft]; %delay(t)-delay(1)
            EDelay = 0:NFFT-1;
            EDelay = exp(-1j*2*pi*(EDelay)*tmpc/nfft).';


            signal_dw = data(t_intp,t);
            SigFFT = fft(signal_dw, nfft);
            SigFFTDelay = SigFFT.*EDelay;
            data_syn(:,t) = ifft(SigFFT, NFFT);

            signal_dw = noise(t_intp,t);
            SigFFT = fft(signal_dw, nfft);
            SigFFTDelay = SigFFT.*EDelay;
            noise_syn(:,t) = ifft(SigFFT, NFFT);
    end


    %     figure;
    %     hold on;
    %     plot(tplotdw,imag(signal_dw),'r.-');
    %     plot(t_intp,imag( data_syn(:,t)),'b.-');


end


end