[audio, FS] = audioread('test.mp3');
audio = audio(100000:110000,1)';
audio_p = PitchScaling(audio, 1);
%audio_fp = formantPreservation(audio, 1);
%soundsc(audio, FS);
%audio_ts = TimeScaling(audio, 1);
%soundsc(audio_ts, FS);
%soundsc(audio, FS);

w = hanning(1024);

figure(1);
spectrogram(audio, w);
figure(2);
spectrogram(audio_p, w);



% figure(1);
% spectrogram(audio_p, w);
% figure(2);
% spectrogram(audio_fp, w);
% figure(3);
% spectrogram(audio, w);

