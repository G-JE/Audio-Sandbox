function [audio_out] = formantPreservation(audio, ratio)

DAFx_in = audio';
n1 = 256;
n2 = n1*ratio;
WLen = 2048;
w1 = hanning(WLen);
w2 = w1;
order = 50;

WLen2 = WLen/2;
lx = floor(WLen*n1/n2);
x = 1 + (0:lx-1)'*WLen/lx;
ix = floor(x);
ix1 = ix + 1;
dx = x - ix;
dx1 = 1 - dx;
warping_coef = n1/n2;
t = 1 + floor((0:WLen-1)*warping_coef);
lmax = max(WLen, t(WLen));
L = length(DAFx_in);

DAFx_in = [zeros(WLen, 1); DAFx_in; zeros(WLen-mod(L,n1),1)]/max(abs(DAFx_in));
DAFx_out = zeros(lx+length(DAFx_in), 1);
omega = 2*pi*n1*[0:WLen-1]'/WLen;
phi0 = zeros(WLen, 1);
psi = zeros(WLen, 1);

pin = 0;
pout = 0;
pend = L - lmax;

while pin < pend
    grain = DAFx_in(pin+1:pin+WLen).*w1;
    f = fft(fftshift(grain));
    r = abs(f);
    phi = angle(f);
    
    delta_phi = omega + princarg(phi-phi0-omega);
    phi0 = phi;
    psi = princarg(psi+delta_phi*ratio);
    
    grain1 = DAFx_in(pin+t).*w1;
    f1 = fft(grain1)/WLen2;
    flog = log(0.00001+abs(f1))-log(0.00001+abs(f));
    cep = ifft(flog);
    cep_cut = [cep(1)/2; cep(2:order); zeros(WLen-order, 1)];
    corr = exp(2*real(fft(cep_cut)));
    
    ft = (r.*corr.*exp(1i*psi));
    grain = fftshift(real(ifft(ft))).*w2;
    grain2 = [grain;0];
    grain3 = grain2(ix).*dx1+grain2(ix1).*dx;
    DAFx_out(pout+1:pout+lx) = DAFx_out(pout+1:pout+lx) + grain3;
    pin = pin + n1;
    pout = pout + n1;
end


audio_out = DAFx_out(WLen+1: WLen+L) / max(abs(DAFx_out));

