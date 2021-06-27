% Ex3
% e)
N = 40;
P = 10000;
alfa = 0.1;
lambda = 1800;
C = 10;
f = [2500,5000,7500,10000,12500,15000,17500,20000];
b = 0;

% Vars to store simulation results
Sim_PL = zeros(1,length(f));
Sim_APD = zeros(1,length(f));
Sim_TT = zeros(1,length(f));

% Vars to store theoretical results
MM1m_PL = zeros(1,length(f));
MM1m_TT = zeros(1,length(f));
MM1m_APD = zeros(1,length(f));
size = AvgPacketSize();
miu = (C*10^6)/size;

for i=1:length(f)
    % Init empty arrays to store N simulation runs
    PL_lst = zeros(1,N);
    APD_lst = zeros(1,N);
    TT_lst = zeros(1,N);
    
    for k=1:N
        [PL_lst(k),APD_lst(k),~,TT_lst(k)] = simulator2(lambda,C,f(i),P,b);
    end
    
    % Calculate Packet Loss for f(i)
    Sim_PL(i) = mean(PL_lst);

    % Calculate Average Packet Delay for f(i)
    Sim_APD(i) = mean(APD_lst);

    % Calculate Throughput for f(i)
    Sim_TT(i) = mean(TT_lst);
    
    % Calculate M/M/1/m theoretical values
    NUM = 0;
    DEN = 0;
    
    M = round(f(i)*8/size) + 1;
    
    for j=0:M
        NUM = NUM + (j*(lambda/miu)^j);
        DEN = DEN + (lambda/miu)^j;
    end
    
    MM1m_PL(i) = (((lambda/miu)^M)/DEN)*100;
    MM1m_APD(i) = ((NUM/DEN)/(lambda*(1-miu)))*1000;
    MM1m_TT(i) = size*lambda*10^(-6);
    MM1m_TT(i) = MM1m_TT(i) - MM1m_TT(i)*(MM1m_PL(i)/100);
end

PL = [Sim_PL; MM1m_PL];

% Bar 1 - Packet Loss
figure(1)
bar(f, PL)
xlabel('Queue Size (Bytes)')
ylabel('%')
title('Packet Loss (%)')
legend({'Simulation','M/M/1/m'},'Location','northeast')
hold on
grid on

APD = [Sim_APD; MM1m_APD];

% Bar 2 - Average Packet Delay
figure(2)
bar(f, APD)
xlabel('Queue Size (Bytes)')
ylabel('%')
title('Average Packet Delay (milliseconds)')
legend({'Simulation','M/M/1/m'},'Location','northeast')
hold on
grid on

TT = [Sim_TT; MM1m_TT];

% Bar 3 - Transmit Throughput
figure(3)
bar(f, TT)
xlabel('Queue Size (Bytes)')
ylabel('%')
title('Transmitted Throughput (Mbps)')
legend({'Simulation','M/M/1/m'},'Location','northeast')
hold on
grid on

%% Helper functions

function avg = AvgPacketSize()
    avg = 0.16 * (64*8) + 0.25 * (110*8) + 0.2 * (1518*8);
    for n = 65:109
        avg = avg + ((0.39/((109 - 65 + 1)+(1517 - 111 + 1))) * (n * 8));
    end
    for j = 111:1517
        avg = avg + ((0.39/((109 - 65 + 1)+(1517 - 111 + 1))) * (j*8));
    end
end
