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
<img width="700" alt="sig" src="https://user-images.githubusercontent.com/89936910/213574480-7b78e42c-3bea-49d6-ac9e-5f9dbdfb06ed.png">

2. Tracer 20.log(|H(f)|) pour différentes pulsations de coupure wc, qu'observez-vous? (Afficher avec semilogx)

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
<img width="700" alt="Screenshot 2023-01-19 232908" src="https://user-images.githubusercontent.com/89936910/213576699-164147c3-107c-4c91-a886-77ce4b8ee0e0.png">

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
<img width="700" alt="Screenshot 2023-01-19 233734" src="https://user-images.githubusercontent.com/89936910/213578007-f59ebc4b-4427-4afc-9912-13c3b1a5fc58.png">

4. Choisissez wc qui vous semble optimal. Le filtre est-il bien choisi ? Pourquoi ?
```matlab



```
5. Observez le signal y(t) obtenu, puis Comparer-le avec le signal que vous auriez souhaité obtenir. Conclusions ?
```matlab



```

# Dé-bruitage d'un signal sonore

Dans son petit studio du CROUS, un mauvais futur ingénieur a enregistré une musique en « .wav » avec un très vieux micro. Le résultat est peu concluant, un bruit strident s'est ajouté à sa musique. Heureusement son voisin, expert en traitement du signal est là pour le secourir :

>- « C'est un bruit très haute fréquence, il suffit de le supprimer. » dit-il sûr de lui.

1. Proposer une méthode pour supprimer ce bruit sur le signal.



 
