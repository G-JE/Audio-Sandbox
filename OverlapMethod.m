% Algorithm for pitch-scaling via time scale with resampling
[signal, Fs] = audioread('test.mp3');
DAFx_in = signal(:,1)';
DAFx_in = DAFx_in(1:500000);

sa = 256;
N = 1024;

M = ceil(length(DAFx_in)/sa);

n1 = 512;
n2 = 256;
ss = round(sa*n1/n2);
L = 256*(n1/n2)/2;

DAFx_in(M*sa+N) = 0;
Overlap = DAFx_in(1:N);

for ni =1: M-1
    grain=DAFx_in(ni*sa+1:N+ni*sa);
    XCORRsegment = xcorr(grain(1:L), Overlap(1,ni*ss:ni*ss+(L-1)));
    [xmax(1,ni), index(1,ni)] = max(XCORRsegment);
    fadeout=1: (-1/(length(Overlap)-(ni*ss-(L-1)+index(1,ni)-1))):0;
    fadein=0:(1/(length(Overlap)-(ni*ss-(L-1)+index(1,ni)-1))):1; 
    Tail = Overlap(1,(ni*ss-(L-1))+index(1,ni)-1:length(Overlap)).*fadeout;
    Begin = grain(1:length(fadein)).*fadein;
    Add = Tail + Begin;
    Overlap = [Overlap(1,1:ni*ss-L+index(1,ni)-1) Add grain(length(fadein)+1:N)];
end

lfen = 2048;
lfen2 = lfen/2;
w1 = hanning(lfen);
w2 = w1;

lx = floor(lfen*n1/n2);
x = 1+(0:lfen-1)'*lx/lfen;

ix = floor(x);
ix1 = ix + 1;
dx = x-ix;
dx1 = 1 - dx;

lmax = max(lfen, lx);

Overlap = Overlap';

DAFx_out = zeros(length(DAFx_in), 1);

pin = 0;
pout = 0;
pend = length(DAFx_in) - lmax;

while pin < pend
    grain2 = (Overlap(pin+ix).*dx1+Overlap(pin+ix1).*dx).*w1;
    DAFx_out(pout+1:pout+lfen) = DAFx_out(pout+1:pout+lfen) + grain2;
    pin = pin+n1;
    pout = pout+n2;
end

DAFx_out = DAFx_out / max(abs(DAFx_out)) ;

soundsc(DAFx_out, Fs);