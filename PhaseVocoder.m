%Basic function showing the analysis and synthesis of an input audio signal
%The signal is taken into the Time Frequency domain where it is able to be
%modulated or filtered before being sent back into the magnitude time
%domain
function[audio_out] = PhaseVocoder (audio_in)
n1 = 512;
n2 = n1;
WLen = 2048;
w1 = hanning(WLen);
w2 = w1;

audio = audio_in;

L = length(audio);

%normalize and padd the audio
audio = [zeros(WLen, 1); audio; zeros(WLen - mod(L,n1),1)] / max(abs(audio));
audio_out = zeros(length(audio),1);

pin = 0;
pout = 0;
pend = length(audio)-WLen;

while pin < pend
    grain = audio(pin+1: pin+WLen).*w1;
    f = fft(fftshift(grain));
    plot(f,0:WLen-1);
    r = abs(f);
    phi = angle(f);
    ft = (r.*exp(1i*phi));
    grain = fftshift(real(ifft(ft))).*w2;
    audio_out(pout+1:pout+WLen) = audio_out(pout+1:pout+WLen) + grain;
    pin = pin+n1;
    pout = pout+n2;
end