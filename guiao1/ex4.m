format long

% Exercise: Consider a wireless link between two stations for data communications. 
% The bit error rate (ber) introduced by the wireless link is approximately
% given by the following Markov chain: 

% % (see guide for more details)

% where the state transition rates are in number of transitions per hour. 
% Consider that the link is in the interference state when its ber is at 
% least 10 -3 and is in the normal state, otherwise. Assume
% that both stations detect with a probability of 100% when the data frames
% sent by the other station are received with errors.

% 4.a: Determine the probability of the link being in the normal state and 
% in the interference state.
P1=1/(1+(8/600)+((8/600)*(5/200))+((8/600)*(5/200)*(2/50))+((8/600)*(5/200)*(2/50)*(1/5)))
P2=(8/600)/(1+(8/600)+((8/600)*(5/200))+((8/600)*(5/200)*(2/50))+((8/600)*(5/200)*(2/50)*(1/5)))
P3=((8/600)*(5/200))/(1+(8/600)+((8/600)*(5/200))+((8/600)*(5/200)*(2/50))+((8/600)*(5/200)*(2/50)*(1/5)))
P4=((8/600)*(5/200)*(2/50))/(1+(8/600)+((8/600)*(5/200))+((8/600)*(5/200)*(2/50))+((8/600)*(5/200)*(2/50)*(1/5)))
P5=((8/600)*(5/200)*(2/50)*(1/5))/(1+(8/600)+((8/600)*(5/200))+((8/600)*(5/200)*(2/50))+((8/600)*(5/200)*(2/50)*(1/5)))

PNS=P1+P2+P3
PIS=P4+P5

% 4.b. Determine the average ber of the link when it is in the normal state
% and when it is in the interference state.
avgberns=((P4*10^-3)+(P5*10^-2))/PNS
avgberis=((P1*10^-6)+(P2*10^-5)+(P3*10^-4))/PIS

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

% 4.d. Consider now that a data frame of size B (in Bytes) sent by one of 
% the stations is received without errors by the other station. 
% Draw a plot of the probability of the link being in the interference state
% as a function of the packet size (from 64 Bytes up to 200 Bytes).
% Analyze and justify the results.
% vetor x
n = linspace(64*8,200*8);

% probabilidade de um pacote chegar sem erros para P1
p = 10^-6;
se1=(1*(p^0)*((1-p).^(n-0)));

% probabilidade de um pacote chegar sem erros para P2
p = 10^-5;
se2=(1*(p^0)*((1-p).^(n-0)));

% probabilidade de um pacote chegar sem erros para P3
p = 10^-4;
se3=(1*(p^0)*((1-p).^(n-0)));

% probabilidade de um pacote chegar sem erros para P4
p = 10^-3;
se4=(1*(p^0)*((1-p).^(n-0)));

% probabilidade de um pacote chegar sem erros para P5
p = 10^-2;
se5=(1*(p^0)*((1-p).^(n-0)));

% vetores y
y4=((se4*P4)./((se1*P1)+(se2*P2)+(se3*P3)+(se4*P4)+(se5*P4)))*100
y5=((se5*P5)./((se1*P1)+(se2*P2)+(se3*P3)+(se4*P4)+(se5*P4)))*100

prob2=y4+y5

% construção gráfico
figure(2)
%vetores
plot(n/8,prob2)
%titulo
title("Probability of the link being in the normal state (package received w/o errors)")
% label x
xlabel("Packet Size (Bytes)")
% label y
ylabel("Probability(%)")
grid on