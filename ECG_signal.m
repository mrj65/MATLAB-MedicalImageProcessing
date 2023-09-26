x = ecg(500).';
y = sgolayfilt(x,0,5);
[M,N] = size(y);
Fs = 1000;
TS = timescope('SampleRate',Fs,...
                    'TimeSpanSource','Property',...
                    'TimeSpan',1.5,...
                    'ShowGrid',true,...
                    'NumInputPorts',2,...
                    'LayoutDimensions',[2 1]);
TS.ActiveDisplay = 1;
TS.YLimits = [-1,1];
TS.Title = 'Noisy Signal';
TS.ActiveDisplay = 2;
TS.YLimits = [-1,1];
TS.Title = 'Filtered Signal';

Fpass  = 200;
Fstop = 400;
Dpass = 0.05;
Dstop = 0.0001;
F     = [0 Fpass Fstop Fs/2]/(Fs/2);
A     = [1 1 0 0];
D     = [Dpass Dstop];
b = firgr('minorder',F,A,D);
LP = dsp.FIRFilter('Numerator',b);

tic;
while toc < 30
    x = .1 * randn(M,N);
    highFreqNoise = HP(x);
    noisySignal = y + highFreqNoise;
    filteredSignal = LP(noisySignal);
    TS(noisySignal,filteredSignal);
end

% Finalize
release(TS)
