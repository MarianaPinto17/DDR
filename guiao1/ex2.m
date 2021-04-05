% Exercise: Consider a wireless link between multiple stations for data  
% communications with a bit error rate (ber) of p. Assume that errors in 
% the different bits of a data packet are statistically independent 
% (i.e., the number of errors of a data packet is a binomial random variable)

% 2.a. Determine the probability of a data packet of 100 Bytes to be received without errors
% when p = 10^−2 . Answer: 0.0322%
p = 10^(-2);
n = 100*8;
e = 0;
ya=(nchoosek(n,e)*(p^e)*((1-p)^(n-e)))*100

% 2.b. Determine the probability of a data packet of 1000 Bytes to be received with exactly one
% error when p = 10^−3 . Answer: 0.2676%
p = 10^(-3);
n = 1000*8;
e = 1;
yb=(nchoosek(n,e)*(p^e)*((1-p)^(n-e)))*100

% 2.c. Determine the probability of a data packet of 200 Bytes to be received with one or more
% errors when p = 10^−4 . Answer: 14.7863%
p = 10^(-4);
n = 200*8;
e = 0;
ac=nchoosek(n,e)*(p^e)*((1-p)^(n-e));
yc = (1 - ac)*100

% 2.d. Draw a plot with the same look as the answer below of the probability of a data packet
% (of size 100 Bytes, 200 Bytes or 1000 Bytes) being received without errors as a function
% of the ber (from p = 10^−8 up to p = 10^−2 ). 
% vetor x
p = logspace(-8,-2);
% vetores y
n=800;
y1 = (nchoosek(n,0)*(p.^0).*((1-p).^(n-0)))*100
n=1600;
y2 = (nchoosek(n,0)*(p.^0).*((1-p).^(n-0)))*100
n=8000;
y3 = (nchoosek(n,0)*(p.^0).*((1-p).^(n-0)))*100
% construção gráfico
figure(1)
% vetores semilogx para colocar o vetor x em logaritmico
% loglog para colocar os dois
semilogx(p,y1,'b',p,y2,'b--',p,y3,'b:')
%legenda
legend('100 bytes', '200 bytes', '1000 bytes','location', 'SouthWest')
%titulo
title("Probability of packet reception without errors (%)")
% label x
xlabel("Bit Error Rate")
% label y
ylabel("")

% 2.e. Draw a plot with the same look as the answer below of the probability of a data packet
% being received without errors (for p = 10^−4 , 10^−3 and 10^−2 ) as a function of the packet
% size (from 64 Bytes up to 1518 Bytes).
% vetor x
n = linspace(64*8,1518*8);
% vetores y
p=10^-4;
y1 = (nchoosek(n,0)*(p.^0).*((1-p).^(n-0)))
p=10^-3;
y2 = (nchoosek(n,0)*(p.^0).*((1-p).^(n-0)))
p=10^-2;
y3 = (nchoosek(n,0)*(p.^0).*((1-p).^(n-0)))
% construção gráfico
figure(2)
% vetores semilogx para colocar o vetor x em logaritmico
% loglog para colocar os dois
semilogy(n,y1,'b',n,y2,'b--',n,y3,'b:')
%legenda
legend('100 bytes', '200 bytes', '1000 bytes','location', 'SouthWest')
%titulo
title("Probability of package reception without errors")
% label x
xlabel("Packet Size (Bytes)")
% label y
ylabel("")