<div id="top"></div>

# TP4 : Filtrage Analogique

![1560174906741](https://user-images.githubusercontent.com/89936910/213545676-a40318b6-d32e-4986-8f04-d3f736e83af6.jpg)

<!-- TABLE OF CONTENTS -->

  <summary>Table of Contents</summary>
  <ol>
   <li><a href="#Objectifs-de-ce-TP">Objectifs de ce TP</a></li>
   <li><a href="#Filtrage-et-diagramme-de-Bode">Filtrage et diagramme de Bode</a></li>
   <li><a href="#Dé-bruitage-d'un-signal-sonore">Dé-bruitage d'un signal sonore</a></li>
   </ol>

# Objectifs 
- Appliquer un filtre réel pour supprimer les composantes indésirables d’un signal. 
- Améliorer la qualité de filtrage en augmentant l’ordre du filtre.

> - Commentaires : Il est à remarquer que ce TP traite en principe des signaux continus. Or, l'utilisation de Matlab suppose l'échantillonnage du signal. Il faudra donc être vigilant par rapport aux différences de traitement entre le temps continu et le temps discret.
> - Tracé des figures : toutes les figures devront être tracées avec les axes et les légendes des axes appropriés.
> - Travail demandé : un script Matlab commenté contenant le travail réalisé et descommentaires sur ce que vous avez compris et pas compris, ou sur ce qui vous a semblé intéressant ou pas, bref tout commentaire pertinent sur le TP.

# Filtrage et diagramme de Bode

Sur le réseau électrique, un utilisateur a branché une prise CPL (Courant Porteur en Ligne), les signaux utiles sont de fréquences élevées. Le réseau électrique a cependant sa propre fréquence (50 hz).
Le boiter de réception doit donc pouvoir filtrer les basses fréquences pour s'attaquer ensuite à la démodulation du signal utile.

<img width="600" alt="Screenshot 2023-01-19 205540" src="https://user-images.githubusercontent.com/89936910/213546428-c3c298cd-0ab5-4321-b887-b45239de24fc.png">

Mathématiquement, un tel filtre fournit un signal de sortie en convoluant le signal d'entrée par la réponse temporelle du filtre :
>               y(t) = x(t) * h(t)

Nous souhaitons appliquer un filtre passe-haut pour supprimer la composante à 50 Hz. Soit notre signal d'entrée :

>               x(t) = sin(2.pi.f1.t) + sin(2.pi.f2.t) + sin(2.pi.f3.t)

Avec f1 = 500 Hz, f2 = 400 Hz et f3 = 50 Hz

1. Définir le signal x(t) sur t = [0 5] avec Te = 0,0001 s.

```matlab
clear all
close all
clc
%qst1
te = 1e-4;
fe=1/te;
t = 0:te:5-te; 
f1=500;
f2=400;
f3=50;

x = sin(2*pi*f1*t)+sin(2*pi*f2*t)+sin(2*pi*f3*t);

```


2. Tracer le signal x(t) et sa transformé de Fourrier. Qu'observez-vous ?
(Essayez de tracer avec Te = 0,0005 s. Remarques ?)

 >vous devriez observer les différentes fréquences présentes dans le signal d'entrée, ainsi que leur amplitude respective. Si vous augmentez Te = 0,0005 s, cela augmentera la résolution temporelle du signal, mais cela pourrait aussi introduire de l'aliasing.

```matlab

%qst2

 subplot(2,1,1)
 plot(t,x,'r');
 title("signal x(t)");
 subplot(2,1,2)
 N=length(x);
 y=fft(x)
 fshift = (-N/2:N/2-1)*(fe/N);
 plot(fshift,fftshift(2*abs(y)/N))
 title("TF du signal x(t)");
```
<img width="700" alt="Screenshot 2023-01-19 230712" src="https://user-images.githubusercontent.com/89936910/213572733-cef5500e-cd29-4d1d-896c-97e46479eac4.png">

La fonction H(f) (transmittance complexe) du filtre passe haut de premier ordre est donnée par :

> H(f) = (K.j.w/wc) / (1 + j. w/wc)

Avec K le gain du signal, w la pulsation et wc la pulsation de coupure. On se propose de tracer le diagramme de Bode de ce filtre et de l'appliquer au signal.

1. Tracer le module de la fonction H(f) avec K=1 et wc = 50 rad/s.


```matlab
%qst3

 k=1;
 f=(0:N-1)*(fe/N);
 wc=50; 
 w1=2*pi*f
 H = (k*1i*w1/wc)./(1+1i*w1/wc);
 module= abs(H);
 plot(w1,module);
 
```
<img width="777" alt="sig" src="https://user-images.githubusercontent.com/89936910/213574480-7b78e42c-3bea-49d6-ac9e-5f9dbdfb06ed.png">

2. Tracer 20.log(|H(f)|) pour différentes pulsations de coupure wc, qu'observez-vous? (Afficher avec semilogx)

>une réponse en fréquence croissante pour des wc plus élevés.

```matlab
wc1=70; 
wc2=500;
wc3=1000;

h1=(k*1i*w1/wc1)./(1+1i*w1/wc1);
h2=(k*1i*w1/wc2)./(1+1i*w1/wc2);
h3=(k*1i*w1/wc3)./(1+1i*w1/wc3);

v1=20*log(abs(h1));
v2=20*log(abs(h2));
v3=20*log(abs(h3));

 subplot(3,1,1);
 plot(w1,v1);
 semilogx(w1,v1,'b');

 subplot(3,1,2);
 % plot(w1,v2);
 semilogx(w1,v3,'r');
 
 subplot(3,1,3);
 % plot(w1,v3);
 semilogx(w1,v3);
```
<img width="777" alt="Screenshot 2023-01-19 232908" src="https://user-images.githubusercontent.com/89936910/213576699-164147c3-107c-4c91-a886-77ce4b8ee0e0.png">

3. Choisissez différentes fréquences de coupure et appliquez ce filtrage dans l'espace des fréquences. Qu'observez-vous ?

```matlab
k=1;
f=(0:N-1)*(fe/N);
w1=2*pi*f

wc1=50;
wc2=1000;
wc3=5000;

H1 = (k*1i*w1/wc1)./(1+1i*w1/wc1);
H2 = (k*1i*w1/wc2)./(1+1i*w1/wc2);
H3 = (k*1i*w1/wc3)./(1+1i*w1/wc3);

fctabs1=abs(H1);
fctabs2=abs(H2);
fctabs3=abs(H3);

subplot(3,1,1);
title("signal with 50 ");
plot(f,fctabs1);

subplot(3,1,2);
title("signal with 1000 ");
plot(f,fctabs2,'r');

subplot(3,1,3);
title("signal with 5000 ");
plot(f,fctabs3);
```
<img width="777" alt="Screenshot 2023-01-19 233734" src="https://user-images.githubusercontent.com/89936910/213578007-f59ebc4b-4427-4afc-9912-13c3b1a5fc58.png">

4. Choisissez wc qui vous semble optimal. Le filtre est-il bien choisi ? Pourquoi ?

- En choisissant différentes fréquences de coupure et en les appliquant au filtrage dans l'espace des fréquences, on  observe que  des effets de suppression de fréquence pour des wc plus élevés. Le choix de wc optimal dépendra de la spécification du système et de la performance souhaitée.
pour notre cas on constate que la composante à 50Hz est réduite ou supprimée .

- Le filtre n'est pas idéal car il est impossible de créer un filtre parfait. Il y aura toujours une certaine perte d'informations. 

<img width="777" alt="Screenshot 2023-01-22 143907" src="https://user-images.githubusercontent.com/89936910/213918842-7cf2f6ef-04e1-4a7f-95a1-02f36eb99573.png">

5. Observez le signal y(t) obtenu, puis Comparer-le avec le signal que vous auriez souhaité obtenir. Conclusions ?
```matlab
 
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

 subplot(2,1,1);
  title("signal (t)");

  plot(t, Yt1) 
  plot(t, Yt2) 
  plot(t, Yt3) 

  yyt1=fft(Yt1)
  yyt2=fft(Yt2)
  yyt3=fft(Yt3)

  subplot(2,1,2);

  plot(fshift,fftshift(abs(yyt1)/N)*2);
  plot(fshift,fftshift(abs(yyt2)/N)*2);
  plot(fshift,fftshift(abs(yyt3)/N)*2)

```
En conclusion, l'application d'un filtre passe-haut permet de supprimer la composante à 50 Hz dans le signal d'entrée x(t). Cela a été réalisé en utilisant la convolution du signal d'entrée avec la réponse temporelle du filtre h(t). Il est important de choisir une fréquence de coupure wc optimale pour obtenir la performance souhaitée, en fonction des spécifications du système. En comparant le signal y(t) obtenu avec le signal désiré, vous pouvez évaluer la performance du filtre et tirer des conclusions sur son efficacité.

<img width="799" alt="Screenshot 2023-01-22 145859" src="https://user-images.githubusercontent.com/89936910/213920013-47947e50-58d3-4b67-9806-6fbb1123d51c.png">

# Dé-bruitage d'un signal sonore

Dans son petit studio du CROUS, un mauvais futur ingénieur a enregistré une musique en « .wav » avec un très vieux micro. Le résultat est peu concluant, un bruit strident s'est ajouté à sa musique. Heureusement son voisin, expert en traitement du signal est là pour le secourir :

>- « C'est un bruit très haute fréquence, il suffit de le supprimer. » dit-il sûr de lui.

1. Proposer une méthode pour supprimer ce bruit sur le signal.
La transmittance complexe est utilisée pour supprimer le bruit sur un signal en utilisant des filtres adaptatifs. Les filtres adaptatifs ajustent leur réponse en fonction de la fréquence et de l'amplitude du signal d'entrée, ce qui permet de supprimer efficacement le bruit tout en préservant les caractéristiques du signal original. Cette méthode est souvent utilisée dans les applications de traitement du signal, telles que la suppression de bruit pour les communications radio et audio.

2. Mettez-la en oeuvre.

> signal avant le filtrage 

```matlab
[music, fs] = audioread('test.wav');
music = music';

N = length(music);

f = (0:N-1)*(fs/N);
fshift = (-N/2:N/2-1)*(fs/N);

spectre_music = fft(music);
 plot(fshift,fftshift(abs(spectre_music)));

```

<img width="777" alt="Screenshot 2023-01-22 152841" src="https://user-images.githubusercontent.com/89936910/213921202-4f41e6f8-5acc-45a9-9dc6-45b76d338a13.png">

> signal apres le filtrage 
```matlab
k = 1;
fc = 4500;
% la transmitance complexe 
h = k./(1+1j*(f/fc).^100);

h_filter = [h(1:floor(N/2)), flip(h(1:floor(N/2)))];

y_filtr = spectre_music(1:end-1).*h_filter;
sig_filtred= ifft(y_filtr,"symmetric");

semilogx(f(1:floor(N/2)),abs( h(1:floor(N/2))),'linewidth',1.5)

plot(fshift(1:end-1),fftshift(abs(fft(sig_filtred))))
```

<img width="777" alt="Screenshot 2023-01-22 153024" src="https://user-images.githubusercontent.com/89936910/213921243-312646de-409b-4c59-acca-f692f52058de.png">

 -  Le paramètre K (ou "ordre") de ces filtres détermine la pente de la réponse en fréquence, plus K est élevé, plus la suppression de bruit sera efficace mais plus il y aura de distorsion dans la signal final.

3. Quelles remarques pouvez-vous faire notamment sur la sonorité du signal final.

Un filtre d'ordre élevé supprimera plus efficacement le bruit, mais pourra également altérer la qualité de la musique. Il est important de trouver un bon compromis entre la suppression de bruit et la qualité de la musique.

4. Améliorer la qualité de filtrage en augmentant l’ordre du filtre.
> on teste avec lordre K=10 
```matlab
k = 10;
fc = 4500;
% la transmitance complexe 
h = k./(1+1j*(f/fc).^100);

h_filter = [h(1:floor(N/2)), flip(h(1:floor(N/2)))];

y_filtr = spectre_music(1:end-1).*h_filter;
sig_filtred= ifft(y_filtr,"symmetric");

 semilogx(f(1:floor(N/2)),abs( h(1:floor(N/2))),'linewidth',1.5)

plot(fshift(1:end-1),fftshift(abs(fft(sig_filtred))))
```

<img width="777" alt="Screenshot 2023-01-22 153930" src="https://user-images.githubusercontent.com/89936910/213921667-f640de0c-7202-40e6-9920-3a2cb6de5373.png">

# Réalisé par : Shadia AIT EL CADI
# Encadré par : Pr. AMMOUR Alae

<p align="right">(<a href="#top">back to top</a>)</p>

