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
    % Init empty arrays to store N simulation runs
    Sim2_PL_lst = zeros(1,N);
    Sim2_APD_lst = zeros(1,N);
    Sim2_MPD_lst = zeros(1,N);
    Sim2_TT_lst = zeros(1,N);

    for k=1:N
        [Sim2_PL_lst(k),Sim2_APD_lst(k),Sim2_MPD_lst(k),Sim2_TT_lst(k)] = simulator2(lambda(i),C,f,P,b);
    end

    % Calculate Simulator 2 Packet Loss for lambda(i)
    Sim2_PL(i) = mean(Sim2_PL_lst);
    Sim2_termPL(i) = norminv(1-alfa/2)*sqrt(var(Sim2_PL_lst)/N);

    % Calculate Simulator 2 Average Packet Delay for lambda(i)
    Sim2_APD(i) = mean(Sim2_APD_lst);
    Sim2_termAPD(i) = norminv(1-alfa/2)*sqrt(var(Sim2_APD_lst)/N);

    % Calculate Simulator 2 Maximum Packet Delay for lambda(i)
    Sim2_MPD(i) = mean(Sim2_MPD_lst);
    Sim2_termMPD(i) = norminv(1-alfa/2)*sqrt(var(Sim2_MPD_lst)/N);

    % Calculate Simulator 2 Throughput for lambda(i)
    Sim2_TT(i) = mean(Sim2_TT_lst);
    Sim2_termTT(i) = norminv(1-alfa/2)*sqrt(var(Sim2_TT_lst)/N);
    
end

% Simulator 3 Run

Sim3_PL = zeros(1,length(lambda));
Sim3_termPL = zeros(1,length(lambda));
Sim3_APD = zeros(1,length(lambda));
Sim3_termAPD = zeros(1,length(lambda));
Sim3_MPD = zeros(1,length(lambda));
Sim3_termMPD = zeros(1,length(lambda));
Sim3_TT = zeros(1,length(lambda));
Sim3_termTT = zeros(1,length(lambda));

for i=1:length(lambda)
    % Init empty arrays to store N simulation runs
    Sim3_PL_lst = zeros(1,N);
    Sim3_APD_lst = zeros(1,N);
    Sim3_MPD_lst = zeros(1,N);
    Sim3_TT_lst = zeros(1,N);

    for k=1:N
        [Sim3_PL_lst(k),Sim3_APD_lst(k),Sim3_MPD_lst(k),Sim3_TT_lst(k)] = simulator3(lambda(i),C,f,P,b)
    end

    % Calculate Simulator 3 Packet Loss for lambda(i)
    Sim3_PL(i) = mean(Sim3_PL_lst);
    Sim3_termPL(i) = norminv(1-alfa/2)*sqrt(var(Sim3_PL_lst)/N);

    % Calculate Simulator 3 Average Packet Delay for lambda(i)
    Sim3_APD(i) = mean(Sim3_APD_lst);
    Sim3_termAPD(i) = norminv(1-alfa/2)*sqrt(var(Sim3_APD_lst)/N);

    % Calculate Simulator 3 Maximum Packet Delay for lambda(i)
    Sim3_MPD(i) = mean(Sim3_MPD_lst);
    Sim3_termMPD(i) = norminv(1-alfa/2)*sqrt(var(Sim3_MPD_lst)/N);

    % Calculate Simulator 3 Throughput for lambda(i)
    Sim3_TT(i) = mean(Sim3_TT_lst);
    Sim3_termTT(i) = norminv(1-alfa/2)*sqrt(var(Sim3_TT_lst)/N);
    
end

% Bars

% Bar 1 - Packet Loss
figure(1)
bar(lambda, [Sim2_PL; Sim3_PL])
xlabel('λ (requests/hour)')
title('Packet Loss (%%)')

% Bar 2 - Average Packet Delay
figure(2)
bar(lambda, [Sim2_APD; Sim3_APD])
xlabel('λ (requests/hour)')
title('Average Packet Delay (milliseconds)')

% Bar 3 - Maximum Packet Delay
figure(3)
bar(lambda, [Sim2_MPD; Sim3_MPD])
xlabel('λ (requests/hour)')
title('Maximum Packet Delay (milliseconds)')

% Bar 4 - Throughput
figure(4)
bar(lambda, [Sim2_TT; Sim3_TT])
xlabel('λ (requests/hour)')
title('Transmitted Throughput (Mbps)')
