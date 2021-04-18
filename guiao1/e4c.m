% 4.c. Consider that a data frame of size B (in Bytes) sent by one of the 
% stations is received with errors by the other station. 
% Draw a plot of the probability of the link being in the normal
% state as a function of the packet size (from 64 Bytes up to 200 Bytes). 
% Analyze and justify the results.
% vetor x
n = linspace(64*8,200*8);

% probabilidade de um pacote chegar com erros para P1
p = 10^-6
ac=(1*(p^0)*((1-p).^(n-0)));
e1=(1-ac)

% probabilidade de um pacote chegar com erros para P2
p = 10^-5;
ac=(1*(p^0)*((1-p).^(n-0)));
e2=(1-ac)

% probabilidade de um pacote chegar com erros para P3
p = 10^-4;
ac=(1*(p^0)*((1-p).^(n-0)));
e3=(1-ac)

% probabilidade de um pacote chegar com erros para P4
p = 10^-3;
ac=(1*(p^0)*((1-p).^(n-0)));
e4=(1-ac)

% probabilidade de um pacote chegar com erros para P5
p = 10^-2;
ac=(1*(p^0)*((1-p).^(n-0)));
e5=(1-ac)

% vetores y
y1=((e1*P1)./((e1*P1)+(e2*P2)+(e3*P3)+(e4*P4)+(e5*P5)))*100
y2=((e2*P2)./((e1*P1)+(e2*P2)+(e3*P3)+(e4*P4)+(e5*P5)))*100
y3=((e3*P3)./((e1*P1)+(e2*P2)+(e3*P3)+(e4*P4)+(e5*P5)))*100

prob=y1+y2+y3
% construção gráfico
figure(1)
%vetores
plot(n/8,prob)
%titulo
title("Probability of the link being in the normal state (package received w/ errors)")
% label x
xlabel("Packet Size (Bytes)")
% label y
ylabel("Probability(%)")
grid on