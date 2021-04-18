% Exercise: Consider again the wireless link between two stations of the 
% previous Task 4. 
% Consider now that the two stations run an interference detection system 
% that works as follows: the stations exchange from time to time a set of n 
% consecutive control frames (each frame with a size of B = 64 Bytes) and 
% the stations decide that the link:
%   - is in the interference state when all n control frames are received 
%   with errors and
%   - is in the normal station if at least one of the n control frames is 
%   received without errors.

% Consider the following definitions:
%   - a false positive is when a station decides wrongly that the link is in 
%   interference state (i.e., it receives the n control frames with error and 
%   the link is in the normal state)
%   - a false negative is when a station decides wrongly that the link is in 
%   the normal state (i.e., at least one of the n control frames is received 
%   without errors and the link is in the interference state)

% 5.a. Draw a plot using a logarithmic scale for the Y-axis (use the MATLAB 
% function semilogy) with the probability of false positives for n = 2, 3, 
% 4 and 5. Analyze and justify the results.
% vetor x
n = linspace(2,5);

% Probabilidade de cada estado normal e em interferencia
P1=1/(1+(8/600)+((8/600)*(5/200))+((8/600)*(5/200)*(2/50))+((8/600)*(5/200)*(2/50)*(1/5)))
P2=(8/600)/(1+(8/600)+((8/600)*(5/200))+((8/600)*(5/200)*(2/50))+((8/600)*(5/200)*(2/50)*(1/5)))
P3=((8/600)*(5/200))/(1+(8/600)+((8/600)*(5/200))+((8/600)*(5/200)*(2/50))+((8/600)*(5/200)*(2/50)*(1/5)))
P4=((8/600)*(5/200)*(2/50))/(1+(8/600)+((8/600)*(5/200))+((8/600)*(5/200)*(2/50))+((8/600)*(5/200)*(2/50)*(1/5)))
P5=((8/600)*(5/200)*(2/50)*(1/5))/(1+(8/600)+((8/600)*(5/200))+((8/600)*(5/200)*(2/50))+((8/600)*(5/200)*(2/50)*(1/5)))

% probabilidade de cada estado ter erro
% probabilidade de um pacote chegar com erros para P1
p = 10^-6
ac1=(1*(p^0)*((1-p).^((64*8)-0)));
e1=(1-ac1)

% probabilidade de um pacote chegar com erros para P2
p = 10^-5;
ac2=(1*(p^0)*((1-p).^((64*8)-0)));
e2=(1-ac2)

% probabilidade de um pacote chegar com erros para P3
p = 10^-4;
ac3=(1*(p^0)*((1-p).^((64*8)-0)));
e3=(1-ac3)

% probabilidade de um pacote chegar com erros para P4
p = 10^-3;
ac4=(1*(p^0)*((1-p).^((64*8)-0)));
e4=(1-ac4)

% probabilidade de um pacote chegar com erros para P5
p = 10^-2;
ac5=(1*(p^0)*((1-p).^((64*8)-0)));
e5=(1-ac5)

% probability of false positives -> probabilidade para cada frame, todos
% terem erros
PE1 = e1.^n;
PE2 = e2.^n;
PE3 = e3.^n;
PE4= e4.^n;
PE5 = e5.^n;

AS = (P1*PE1)+(P2*PE2)+(P3*PE3)+(P4*PE4)+(P5*PE5);
y1 = (((P1*PE1)+(P2*PE2)+(P3*PE3))./AS)*100;
% construção gráfico
figure(1)
%vetores
semilogy(n,y1)
%titulo
title("Probability o")
% label x
xlabel("False positives")
% label y
ylabel("Probability(%)")
grid on

% 5.b. Draw a plot with the probability of false negatives for n = 2, 3, 4 
% and 5. Analyze and justify the results.
y2 = (((P4)*(1-PE4))+((P5)*(1-PE5))./(1-AS))*100;
% label y
% construção gráfico
figure(2)
%vetores
semilogy(n,y2)
%titulo
title("Probability o")
% label x
xlabel("False positives")
% label y
ylabel("Probability(%)")
grid on


% 5.c. Assume that the probabilities of false positives and false negatives
% are equally important in the accuracy of the interference detection system. 
% From the plots obtained in 5.a and 5.b, determine the best value of n to 
% be used by the system. Justify your answer.
