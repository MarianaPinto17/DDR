% Ex 2
% a)
N = 20;
P = 10000;
alfa = 0.1;
lambda = 1800;
C = 10;
f = 1000000;
b = 10^-6;

PL_lst = zeros(1,N);
APD_lst = zeros(1,N);
MPD_lst = zeros(1,N);
TT_lst = zeros(1,N);

for i=1:N
    [PL_lst(i),APD_lst(i),MPD_lst(i),TT_lst(i)] = simulator2(lambda,C,f,P,b);
end

% Calculate Packet Loss
PL = mean(PL_lst);
PL_conf = norminv(1-alfa/2)*sqrt(var(PL_lst)/N);
fprintf('Packet Loss (%%)= %.2e +-%.2e\n',PL,PL_conf);

% Calculate Average Packet Delay
APD = mean(APD_lst);
APD_conf = norminv(1-alfa/2)*sqrt(var(APD_lst)/N);
fprintf('Av. Packet Delay (ms)= %.2e +-%.2e\n',APD,APD_conf);

% Calculate Maximum Packet Delay
MPD = mean(MPD_lst);
MPD_conf = norminv(1-alfa/2)*sqrt(var(MPD_lst)/N);
fprintf('Max. Packet Delay (ms)= %.2e +-%.2e\n',MPD,MPD_conf);

% Calculate Throughput
TT = mean(TT_lst);
TT_conf = norminv(1-alfa/2)*sqrt(var(TT_lst)/N);
fprintf('Throughput (Mbps)= %.2e +-%.2e\n',TT,TT_conf);
