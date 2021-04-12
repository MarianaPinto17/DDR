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
P2=8/600/(1+(8/600)+((8/600)*(5/200))+((8/600)*(5/200)*(2/50))+((8/600)*(5/200)*(2/50)*(1/5)))
P3=((8/600)*(5/200))/(1+(8/600)+((8/600)*(5/200))+((8/600)*(5/200)*(2/50))+((8/600)*(5/200)*(2/50)*(1/5)))
P4=((8/600)*(5/200)*(2/50))/(1+(8/600)+((8/600)*(5/200))+((8/600)*(5/200)*(2/50))+((8/600)*(5/200)*(2/50)*(1/5)))
P5=((8/600)*(5/200)*(2/50)*(1/5))/(1+(8/600)+((8/600)*(5/200))+((8/600)*(5/200)*(2/50))+((8/600)*(5/200)*(2/50)*(1/5)))

PNS=P1+P2+P3
PIS=P4+P5

% 4.b. Determine the average ber of the link when it is in the normal state
% and when it is in the interference state.
avgberns=((P4*10^-3)+(P5*10^-2))/PIS
avgberis=((P1*10^-6)+(P2*10^-5)+(P3*10^-4))/PNS

% 4.c. Consider that a data frame of size B (in Bytes) sent by one of the 
% stations is received with errors by the other station. 
% Draw a plot of the probability of the link being in the normal
% state as a function of the packet size (from 64 Bytes up to 200 Bytes). 
% Analyze and justify the results.
% vetor x
n = linspace(64*8,200*8);
% vetores y


% construção gráfico
figure(1)
% vetores semilogx para colocar o vetor x em logaritmico
% loglog para colocar os dois
semilogy(n/8,y1,'b',n/8,y2,'b--',n/8,y3,'b:')
%legenda
legend('P1', 'P2', 'P3', 'P4', 'P5','location', 'SouthWest')
%titulo
title("Probability of the link being in the normal state (package received w/ errors)")
% label x
xlabel("Packet Size (Bytes)")
% label y
ylabel("")


% 4.d. Consider now that a data frame of size B (in Bytes) sent by one of 
% the stations is received without errors by the other station. 
% Draw a plot of the probability of the link being in the interference state
% as a function of the packet size (from 64 Bytes up to 200 Bytes).
% Analyze and justify the results.
% vetor x
n = linspace(64*8,200*8);
% vetores y


% construção gráfico
figure(2)
% vetores semilogx para colocar o vetor x em logaritmico
% loglog para colocar os dois
semilogy(n/8,y1,'b',n/8,y2,'b--',n/8,y3,'b:')
%legenda
legend('P1', 'P2', 'P3', 'P4', 'P5','location', 'SouthWest')
%titulo
title("Probability of the link being in the interferance state (package received w/o errors)")
% label x
xlabel("Packet Size (Bytes)")
% label y
ylabel("")
