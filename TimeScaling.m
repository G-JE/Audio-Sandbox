function [audio_out] = TimeScaling(audio, ratio)
WLen = 1024;
nChannel = WLen / 2;
w1 = blackman(WLen);
w2 = w1;
n1 = 512;
pit_ratio = 0.750;
n2 = n1*ratio;

DAFx_in = audio';
L = length(DAFx_in);
g = zeros(WLen, 1);
h = zeros(WLen - mod(L, n1), 1);
DAFx_in = [g; DAFx_in; h] / max(abs(DAFx_in));
tstretch_ratio = n2/n1;
DAFx_out = zeros(length(DAFx_in),1);
grain = zeros(WLen, 1);
ll = WLen/2;
omega = 2*pi*n1*[0:(ll-1)]'/WLen;
phi0 = zeros(ll,1);
r0 = zeros(ll,1);
psi = zeros(ll,1);
res = zeros(n1,1);

tic
pin = 0;
pout = 0;
pend = length(DAFx_in) - WLen;

while pin < pend
    grain = DAFx_in((pin + 1):(pin+WLen)).*w1;
    fc = fft(fftshift(grain));
    f = fc(1:ll);
    r = abs(f);
    phi = angle(f);
    delta_phi = omega + princarg(phi-phi0-omega);
    delta_r = (r - r0)/n1;
    delta_psi = pit_ratio*delta_phi/n1;
    for k = 1:n1
        r0 = r0 + delta_r;
        psi = psi + delta_psi;
        res(k)= r0'*cos(psi);
    end
    
    phi0 = phi;
    r0 = r;
    psi = princarg(psi);
    
    DAFx_out(pout+1:pout+n1) = DAFx_out(pout+1:pout+n1)+res;
    pin = pin + n1;
    pout = pout + n1;
end

toc

audio_out = DAFx_out (WLen/2 + n1 + 1: length(DAFx_out)) / max(abs (DAFx_out) ) ;
