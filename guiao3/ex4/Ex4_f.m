% Ex4
% f)

N = 10;
P = 100000;
lambda = 1800;
C = 10;
f = [2500,5000,7500,10000,12500,15000,17500,20000];
b = 10^(-5);

% Simulator 2 Run

Sim2_PL = zeros(1,length(lambda));
Sim2_termPL = zeros(1,length(lambda));
Sim2_APD = zeros(1,length(lambda));
Sim2_termAPD = zeros(1,length(lambda));
Sim2_MPD = zeros(1,length(lambda));
Sim2_termMPD = zeros(1,length(lambda));
Sim2_TT = zeros(1,length(lambda));
Sim2_termTT = zeros(1,length(lambda));

for i=1:length(f)
    % Init empty arrays to store N simulation runs
    Sim2_PL_lst = zeros(1,N);
    Sim2_APD_lst = zeros(1,N);
    Sim2_MPD_lst = zeros(1,N);
    Sim2_TT_lst = zeros(1,N);

    for k=1:N
        [Sim2_PL_lst(k),Sim2_APD_lst(k),Sim2_MPD_lst(k),Sim2_TT_lst(k)] = simulator2(lambda,C,f(i),P,b);
    end

    % Calculate Simulator 2 Packet Loss for f(i)
    Sim2_PL(i) = mean(Sim2_PL_lst);
    Sim2_termPL(i) = norminv(1-alfa/2)*sqrt(var(Sim2_PL_lst)/N);

    % Calculate Simulator 2 Average Packet Delay for f(i)
    Sim2_APD(i) = mean(Sim2_APD_lst);
    Sim2_termAPD(i) = norminv(1-alfa/2)*sqrt(var(Sim2_APD_lst)/N);

    % Calculate Simulator 2 Maximum Packet Delay for f(i)
    Sim2_MPD(i) = mean(Sim2_MPD_lst);
    Sim2_termMPD(i) = norminv(1-alfa/2)*sqrt(var(Sim2_MPD_lst)/N);

    % Calculate Simulator 2 Throughput for f(i)
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

for i=1:length(f)
    % Init empty arrays to store N simulation runs
    Sim3_PL_lst = zeros(1,N);
    Sim3_APD_lst = zeros(1,N);
    Sim3_MPD_lst = zeros(1,N);
    Sim3_TT_lst = zeros(1,N);

    for k=1:N
        [Sim3_PL_lst(k),Sim3_APD_lst(k),Sim3_MPD_lst(k),Sim3_TT_lst(k)] = simulator3(lambda,C,f(i),P,b);
    end

    % Calculate Simulator 3 Packet Loss for f(i)
    Sim3_PL(i) = mean(Sim3_PL_lst);
    Sim3_termPL(i) = norminv(1-alfa/2)*sqrt(var(Sim3_PL_lst)/N);

    % Calculate Simulator 3 Average Packet Delay for f(i)
    Sim3_APD(i) = mean(Sim3_APD_lst);
    Sim3_termAPD(i) = norminv(1-alfa/2)*sqrt(var(Sim3_APD_lst)/N);

    % Calculate Simulator 3 Maximum Packet Delay for f(i)
    Sim3_MPD(i) = mean(Sim3_MPD_lst);
    Sim3_termMPD(i) = norminv(1-alfa/2)*sqrt(var(Sim3_MPD_lst)/N);

    % Calculate Simulator 3 Throughput for f(i)
    Sim3_TT(i) = mean(Sim3_TT_lst);
    Sim3_termTT(i) = norminv(1-alfa/2)*sqrt(var(Sim3_TT_lst)/N);
    
end

% Bars

% Bar 1 - Packet Loss
figure(1)
bar(f, [Sim2_PL; Sim3_PL])
xlabel('Queue Size (Bytes)')
title('Packet Loss (%)')
legend('Simulator2', 'Simulator3', 'location', 'NorthWest')

% Bar 2 - Average Packet Delay
figure(2)
bar(f, [Sim2_APD; Sim3_APD])
xlabel('Queue Size (Bytes)')
title('Average Packet Delay (milliseconds)')
legend('Simulator2', 'Simulator3', 'location', 'NorthWest')

% Bar 3 - Maximum Packet Delay
figure(3)
bar(f, [Sim2_MPD; Sim3_MPD])
xlabel('Queue Size (Bytes)')
title('Maximum Packet Delay (milliseconds)')
legend('Simulator2', 'Simulator3', 'location', 'NorthWest')

% Bar 4 - Throughput
figure(4)
bar(f, [Sim2_TT; Sim3_TT])
xlabel('Queue Size (Bytes)')
title('Transmitted Throughput (Mbps)')
legend('Simulator2', 'Simulator3', 'location', 'NorthWest')
