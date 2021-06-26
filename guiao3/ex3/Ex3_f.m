% Ex3
% f)
N = 40;
P = 10000;
alfa = 0.1;
lambda = 1800;
C = 10;
f = [2500,5000,7500,10000,12500,15000,17500,20000];
b = 10^(-5);

PL = zeros(1,length(f));
termPL = zeros(1,length(f));
APD = zeros(1,length(f));
termAPD = zeros(1,length(f));
MPD = zeros(1,length(f));
termMPD = zeros(1,length(f));
TT = zeros(1,length(f));
termTT = zeros(1,length(f));

for i=1:length(f)
    % Init empty arrays to store N simulation runs
    PL_lst = zeros(1,N);
    APD_lst = zeros(1,N);
    MPD_lst = zeros(1,N);
    TT_lst = zeros(1,N);
    
    for k=1:N
        [PL_lst(k),APD_lst(k),MPD_lst(k),TT_lst(k)] = simulator2(lambda,C,f(i),P,b);
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
bar(f, PL)
xlabel('Queue Size (Bytes)')
title('Packet Loss (%)')
hold on
err = errorbar(f, PL, termPL, termPL);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

% Bar 2 - Average Packet Delay
figure(2)
bar(f, APD)
xlabel('Queue Size (Bytes)')
title('Average Packet Delay (milliseconds)')
hold on
err = errorbar(f, APD, termAPD, termAPD);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

% Bar 3 - Maximum Packet Delay
figure(3)
bar(f, MPD)
xlabel('Queue Size (Bytes)')
title('Maximum Packet Delay (milliseconds)')
hold on
err = errorbar(f, MPD, termMPD, termMPD);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

% Bar 4 - Transmit Throughput
figure(4)
bar(f, TT)
xlabel('Queue Size (Bytes)')
title('Transmitted Throughput (Mbps)')
hold on
err = errorbar(f, TT, termTT, termTT);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off
