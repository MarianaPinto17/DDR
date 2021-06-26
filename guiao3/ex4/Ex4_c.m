% Ex4
% a)

N = 10;
P = 100000;
alfa = 0.1;
lambda = [1500,1600,1700,1800,1900,2000];
C = 10;
f = 10^7;
b = 0;

% Simulator 2 Run

Sim2_PL = zeros(1,length(lambda));
Sim2_termPL = zeros(1,length(lambda));
Sim2_APD = zeros(1,length(lambda));
Sim2_termAPD = zeros(1,length(lambda));
Sim2_MPD = zeros(1,length(lambda));
Sim2_termMPD = zeros(1,length(lambda));
Sim2_TT = zeros(1,length(lambda));
Sim2_termTT = zeros(1,length(lambda));

for i=1:length(lambda)

    Sim2_PL_lst = zeros(1,N);
    Sim2_APD_lst = zeros(1,N);
    Sim2_MPD_lst = zeros(1,N);
    Sim2_TT_lst = zeros(1,N);

    for i=1:N
        [Sim2_PL_lst(i),Sim2_APD_lst(i),Sim2_MPD_lst(i),Sim2_TT_lst(i)] = simulator2(lambda(i),C,f,P,b)
    end

    % Calculate Simulator 2 Packet Loss for lambda(i)
    Sim2_PL(i) = mean(Sim2_PL_lst);
    Sim2_termPL(i) = norminv(1-alfa/2)*sqrt(var(Sim2_PL_lst)/N);


    % Calculate Simulator 2 Average Packet Delay for lambda(i)
    Sim2_APD = mean(Sim2_APD_lst);
    Sim2_termAPD = norminv(1-alfa/2)*sqrt(var(SiAPD_lst)/N);


% Calculate Maximum Packet Delay
MPD = mean(MPD_lst);
MPD_conf = norminv(1-alfa/2)*sqrt(var(MPD_lst)/N);
fprintf('Max. Packet Delay (ms)= %.2e +-%.2e\n',MPD,MPD_conf);

% Calculate Throughput
TT = mean(TT_lst);
TT_conf = norminv(1-alfa/2)*sqrt(var(TT_lst)/N);
fprintf('Throughput (Mbps)= %.2e +-%.2e\n',TT,TT_conf);
