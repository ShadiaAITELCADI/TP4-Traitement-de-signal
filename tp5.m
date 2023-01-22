clear all
close all
clc

%%
%qst1:  Définir le signal x(t) sur t = [0 5] avec Te = 0,0001 s.

te = 1e-4;
fe=1/te;
t = 0:te:5-te; 
f1=500;
f2=400;
f3=50;

x = sin(2*pi*f1*t)+sin(2*pi*f2*t)+sin(2*pi*f3*t);

%%

%qst2

%  subplot(2,1,1)
%  plot(t,x,'b');
%  title("signal x(t)");
%  subplot(2,1,2)
%  N=length(x);
%   y=fft(x)
%  fshift = (-N/2:N/2-1)*(fe/N);
%  plot(fshift,fftshift(2*abs(y)/N))
%  title("TF du signal x(t)");
 
 
%la fuite spectrale on a trouve une valeur approchee de 50 : 49.x, pour
%pouvoir generer la valeur exacte on augmente le nbr d echantillons  ( one diminue une te) t = 0:te:5-te;
%%
% %qst3

k=1;
f=(0:N-1)*(fe/N);
fshift = (-N/2:N/2-1)*fe/N;
wc=50; 
w1=2*pi*f
H = (k*1i*w1/wc)./(1+1i*w1/wc);
module= abs(H);
% plot(w1,module,'r');


 %%
%2. Tracer 20.log(|H(f)|) pour différentes pulsations de coupure wc, qu'observez-vous
% wc1=50; 
% wc2=500;
% wc3=1000;
% 
% h1=(k*1i*w1/wc1)./(1+1i*w1/wc1);
% h2=(k*1i*w1/wc2)./(1+1i*w1/wc2);
% h3=(k*1i*w1/wc3)./(1+1i*w1/wc3);
% 
% v1=20*log(abs(h1));
% v2=20*log(abs(h2));
% v3=20*log(abs(h3));
% 
% subplot(3,1,1);
%  title("signal 1 with semilog ");
%  plot(w1,v1);
%  semilogx(w1,v1,'b');
% 
% subplot(3,1,2);
% % plot(w1,v2);
% semilogx(w1,v3,'r');
% subplot(3,1,3);
% % plot(w1,v3);
% semilogx(w1,v3);

% %% 
% %  Choisissez différentes fréquences de coupure et appliquez ce filtrage dans l'espace des fréquences. Qu'observez-vous 
% 
% k=1;
% f=(0:N-1)*(fe/N);
% w1=2*pi*f
% 
% wc1=50;
% wc2=1000;
% wc3=5000;
% 
% H1 = (k*1i*w1/wc1)./(1+1i*w1/wc1);
% H2 = (k*1i*w1/wc2)./(1+1i*w1/wc2);
% H3 = (k*1i*w1/wc3)./(1+1i*w1/wc3);
% 
% fctabs1=abs(H1);
% fctabs2=abs(H2);
% fctabs3=abs(H3);
% 
% subplot(3,1,1);
% title("signal with 50 ");
% plot(f,fctabs1);
% 
% subplot(3,1,2);
% title("signal with 1000 ");
% plot(f,fctabs2,'r');
% 
% subplot(3,1,3);
% title("signal with 5000 ");
% plot(f,fctabs3);

% % 
%4. Choisissez wc qui vous semble optimal. Le filtre est-il bien choisi ? Pourquoi ?
%l'élimination la composante à 50 Hz.
%%
% %Observez le signal y(t) obtenu, puis Comparer-le avec le signal que vous auriez souhaité obtenir. Conclusions ?
 
 wc1=50; 
 wc2=500;
 wc3=1000;

 tansf = fft(x);
 H1 = (k*1i*w1/wc1)./(1+1i*w1/wc1);
 H2 = (k*1i*w1/wc2)./(1+1i*w1/wc2);
 H3 = (k*1i*w1/wc3)./(1+1i*w1/wc3);
 yt1 = tansf.*H1 ; 
 yt2 = tansf.*H2 ; 
 yt3 = tansf.*H3 ;

 Yt1 =ifft(yt1,'symmetric');
 Yt2 =ifft(yt2,'symmetric'); 
 Yt3 =ifft(yt3,'symmetric');

%  subplot(2,1,1);
%  title("signal (t)");

%  plot(t, Yt1) 
%  plot(t, Yt2) 
%  plot(t, Yt3) 

%  yyt1=fft(Yt1)
%  yyt2=fft(Yt2)
%  yyt3=fft(Yt3)

%  subplot(2,1,2);

%  plot(fshift,fftshift(abs(yyt1)/N)*2);
%  plot(fshift,fftshift(abs(yyt2)/N)*2);
%  plot(fshift,fftshift(abs(yyt3)/N)*2)

 
 