%% Conner Brown
%  Date Created 8/18/16
%  Last Edited  8/18/16
%  Chord.m
%  Determine scale used in song. Furthermore, determine chord progression
%  and when chords are played. Identify chorus, verse, bridge etc
clear
clc
tic

directory=dir('Samples\*.mp3');
file=2;
[y,Fs]=audioread(strcat('Samples\',directory(file).name));
L=length(y);
t=(0:L-1)/Fs;
f=Fs*(0:(L/2))/L;

%% Frequency spectrum of the whole song
% fft of 2D vector y
yfft=fft(y);
full=abs(yfft/L);
% channel 1
chan1=full(1:L/2+1,1);
chan1(2:end-1)=2*chan1(2:end-1);
% channel 2
% chan2=full(1:L/2+1,2);
% chan2(2:end-1)=2*chan2(2:end-1);
% plotting fft
% figure 
% % subplot(2,1,1)
% plot(f,chan1)
% title('channel1 spectrum')
% subplot(2,1,2)
% plot(f,chan2)

%% Group all similar frequencies into bins of notes
% notes=zeros(1,12);
% bins=1:12;
% letters=['A' '#' 'B' 'C' '#' 'D' '#' 'E' 'F' '#' 'G' '#'];
% for n=-24:24
%     lownote=round(440*2^((n-.5)/12));
%     highnote=round(440*2^((n+.5)/12));
%     binamp=sum(chan1(lownote:highnote,1));
%     notes(1,mod(n,12)+1)=notes(1,mod(n,12)+1)+binamp;
% end
% figure
% stem(bins,notes) % 1=A

%% Spectrogram: really just a STFT
% take max length of slowest bpm as segment (1 sec should do)
% time resolution should identify between 1 bpm (1/60)
spec=y(6*Fs:7*Fs,1);
timeres=round(length(spec)/60);
overlap=round(80/100*timeres);
figure
spectrogram(spec,timeres,overlap,[],Fs,'yaxis','MinThreshold',-70);
ylim([.1 2])