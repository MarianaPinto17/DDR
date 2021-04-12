% Exercise: Consider a wireless link between multiple stations for data 
% communications. The bit error rate (ber) introduced by the wireless link 
% (due to the variation of the propagation and interference factors along 
% with time) is approximately given by the following Markov chain:

% % (see guide for more details)

% where the state transition rates are in number of transitions per hour. 
% Consider that the link is in an interference state when its ber is at 
% least 10 -3 and in a normal state, otherwise. Determine:

% 3.a. the probability of the link being in one of the five states; 
% answer: 9.87x10^-1 (10^-6), 5.48x10^-3 (10^-5), 2.74x10^-3 (10^-4), 1.37x10^-3 (10^-3), 3.43x10^-3 (10^-2)
P1=1/(1+(1/180)+((1/180)*(2/4))+((1/180)*(2/4)*(1/2))+((1/180)*(2/4)*(1/2)*(5/2)))
P2=(1/180)/(1+(1/180)+((1/180)*(2/4))+((1/180)*(2/4)*(1/2))+((1/180)*(2/4)*(1/2)*(5/2)))
P3=((1/180)*(2/4))/(1+(1/180)+((1/180)*(2/4))+((1/180)*(2/4)*(1/2))+((1/180)*(2/4)*(1/2)*(5/2)))
P4=((1/180)*(2/4)*(1/2))/(1+(1/180)+((1/180)*(2/4))+((1/180)*(2/4)*(1/2))+((1/180)*(2/4)*(1/2)*(5/2)))
P5=((1/180)*(2/4)*(1/2)*(5/2))/(1+(1/180)+((1/180)*(2/4))+((1/180)*(2/4)*(1/2))+((1/180)*(2/4)*(1/2)*(5/2)))

% 3.b. the average percentage of time the link is in each of the five states;
% answer: 9.87x10^-1 (10^-6), 5.48x10^-3 (10^-5), 2.74x10^-3 (10^-4), 1.37x10^-3 (10^-3), 3.43x10^-3 (10^-2)
P1=1/(1+(1/180)+((1/180)*(2/4))+((1/180)*(2/4)*(1/2))+((1/180)*(2/4)*(1/2)*(5/2)))
P2=(1/180)/(1+(1/180)+((1/180)*(2/4))+((1/180)*(2/4)*(1/2))+((1/180)*(2/4)*(1/2)*(5/2)))
P3=((1/180)*(2/4))/(1+(1/180)+((1/180)*(2/4))+((1/180)*(2/4)*(1/2))+((1/180)*(2/4)*(1/2)*(5/2)))
P4=((1/180)*(2/4)*(1/2))/(1+(1/180)+((1/180)*(2/4))+((1/180)*(2/4)*(1/2))+((1/180)*(2/4)*(1/2)*(5/2)))
P5=((1/180)*(2/4)*(1/2)*(5/2))/(1+(1/180)+((1/180)*(2/4))+((1/180)*(2/4)*(1/2))+((1/180)*(2/4)*(1/2)*(5/2)))


%3.c. the average ber of the link; answer: 3.70x10^-5
avgber=(10^-6*P1)+(10^-5*P2)+(10^-4*P3)+(10^-3*P4)+(10^-2*P5)

%3.d. the average time duration (in minutes) that the link stays in each of the five states;
%answer: 60.0 (10^-6 ), 0.30 (10^-5 ), 1.20 (10^-4 ), 2.40 (10^-3), 30.0 (10^-2)
T1=(1/1)*60
T2=(1/(180+20))*60
T3=(1/(40+10))*60
T4=(1/(20+5))*60
T5=(1/(2))*60

%3.e. the probability of the link being in interference state; answer: 4.80x10^-3
PI=P4+P5

%3.f.the average ber of the link when it is in the interference state. Answer: 7.4310 -3
avgberi=((10^-3*P4)+(10^-2*P5))/PI