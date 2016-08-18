clear;clc;
w=logspace(2,7,200);
L1 = 0.26*1e-3;
L2 = 0.13*1e-3;
R = 0;
R1 = 0.3;
C = 30*1e-6;
list_R = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
figure(1)
for n = 1:size(list_R,2)
    R1 = list_R(n);
    num = [L2*R1*C L2 0];
    den = [L1*L2*C (L1*R1*C+L2*R*C+L2*R1*C) (L1+L2+R*R1*C) R];
    bode(tf(num,den),w)
    hold on;
end
grid;
hold off;
figure(2)
for n = 1:size(list_R,2)
    R1 = list_R(n);
    num = [L2*R1*C L2 0];
    den = [L1*L2*C (L1*R1*C+L2*R*C+L2*R1*C) (L1+L2+R*R1*C) R];
    h=freqs(num,den,w);
    semilogx(w,rad2deg(angle(h)));
    xlabel('Frequency')
    ylabel('Phase(deg)');
    hold on;
end
grid;
hold off;
figure(3)
for n = 1:size(list_R,2)
    R1 = list_R(n);
    num = [L2*R1*C L2 0];
    den = [L1*L2*C (L1*R1*C+L2*R*C+L2*R1*C) (L1+L2+R*R1*C) R];
    h=freqs(num,den,w);
    semilogx(w,abs(h));
    xlabel('Frequency')
    ylabel('Magnitude(dB)');
    hold on;
end
grid;
hold off;

