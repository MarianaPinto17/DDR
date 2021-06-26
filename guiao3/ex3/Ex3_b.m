% Ex3
% b)
N = 40;
P = 10000;
alfa = 0.1;
lambda = [1500,1600,1700,1800,1900,2000];
C = 10;
f = 10^7;
b = 0;

PL = zeros(1,length(lambda));
termPL = zeros(1,length(lambda));
APD = zeros(1,length(lambda));
termAPD = zeros(1,length(lambda));
MPD = zeros(1,length(lambda));
termMPD = zeros(1,length(lambda));
TT = zeros(1,length(lambda));
termTT = zeros(1,length(lambda));

for i=1:length(lambda)
    % Init empty arrays to store N simulation runs
    PL_lst = zeros(1,N);
    APD_lst = zeros(1,N);
    MPD_lst = zeros(1,N);
    TT_lst = zeros(1,N);
    
    for k=1:N
        [PL_lst(k),APD_lst(k),MPD_lst(k),TT_lst(k)] = simulator2(lambda(i),C,f,P,b);
    end
    
    % Calculate Packet Loss for lambda(i)
    PL(i) = mean(PL_lst);
    termPL(i) = norminv(1-alfa/2)*sqrt(var(PL_lst)/N);

    % Calculate Average Packet Delay for lambda(i)
    APD(i) = mean(APD_lst);
    termAPD(i) = norminv(1-alfa/2)*sqrt(var(APD_lst)/N);

    % Calculate Maximum Packet Delay for lambda(i)
    MPD(i) = mean(MPD_lst);
    termMPD(i) = norminv(1-alfa/2)*sqrt(var(MPD_lst)/N);

    % Calculate Throughput for lambda(i)
    TT(i) = mean(TT_lst);
    termTT(i) = norminv(1-alfa/2)*sqrt(var(TT_lst)/N);
    
end

% Bar 1 - Packet Loss
figure(1)
bar(lambda, PL)
xlabel('λ (requests/hour)')
title('Packet Loss (%)')
hold on
err = errorbar(lambda, PL, termPL, termPL);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

% Bar 2 - Average Packet Delay
figure(2)
bar(lambda, APD)
xlabel('λ (requests/hour)')
title('Average Packet Delay (milliseconds)')
hold on
err = errorbar(lambda, APD, termAPD, termAPD);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

% Bar 3 - Maximum Packet Delay
figure(3)
bar(lambda, MPD)
xlabel('λ (requests/hour)')
title('Maximum Packet Delay (milliseconds)')
hold on
err = errorbar(lambda, MPD, termMPD, termMPD);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

% Bar 4 - Transmit Throughput
figure(4)
bar(lambda, TT)
xlabel('λ (requests/hour)')
title('Transmitted Throughput (Mbps)')
hold on
err = errorbar(lambda, TT, termTT, termTT);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off
