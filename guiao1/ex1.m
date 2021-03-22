% 1.a : When p = 60% and n = 4, determine the probability of the student to
% select the right answer. Answer = 70%
n = 4;
p = 0.6;
ya = p + (1 - p) / n

% 1.b: When p = 70% and n = 5, determine the probability of the student to known the
% answer when he selects the right answer. Answer: 92.1%
n = 5;
p = 0.7;
yb = p * n /(1 + (n - 1) *  p)

% 1.c:Draw a plot with the same look as the answer below of the probability of the student to
% select the right answer as a function of the probability p (consider n = 3, 4 and 5).
% vetor x
p = linspace(0,1,101);
% vetores y
n=3;
y1 = p + (1 - p) / n;
n=4;
y2 = p + (1 - p) / n;
n=5;
y3 = p + (1 - p) / n;
% construção gráfico
figure(1)
% vetores
plot(p*100,y1*100,'b',p*100,y2*100,'b--',p*100,y3*100,'b:')
%legenda
legend('n=3', 'n=4', 'n=5','location', 'NorthWest')
%titulo
title("Probability of right answer (%)")
% label x
xlabel("p(%)")
% label y
ylabel("")
% valores limites dos vetores
axis([0 100 0 100])
% grelha on
grid on

% 1.d: Draw a plot with the same look as the answer below of the probability of the student to
% know the answer when he selects the right answer as a function of the probability p
% (consider n = 3, 4 and 5).

p = linspace(0,1,101);
n=3;
% uso do ponto para 
y4 = p * n ./(1 + (n - 1) *  p);
n=4;
y5 = p * n ./(1 + (n - 1) *  p);
n=5;
y6 = p * n ./(1 + (n - 1) *  p);

figure(2)
plot(p*100,y4*100,'b',p*100,y5*100,'b--',p*100,y6*100,'b:')
legend('n=3', 'n=4', 'n=5', 'location', 'NorthWest')
title("Probability of knowing answer (%)")
xlabel("p(%)")
ylabel("")
axis([0 100 0 100])
grid on

