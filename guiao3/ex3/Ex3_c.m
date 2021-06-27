% Ex3
% c)
N = 40;
P = 10000;
alfa = 0.1;
lambda = [1500,1600,1700,1800,1900,2000];
C = 10;
f = 10^7;
b = 0;

% Vars to store simulation results
Sim_APD = zeros(1,length(lambda));
Sim_TT = zeros(1,length(lambda));

% Vars to store theoretical results
MM1_TT = zeros(2,length(lambda));
MM1_Theoretical_APD = zeros(2,length(lambda));
size = AvgPacketSize();

for i=1:length(lambda)
    % Init empty arrays to store N simulation runs
    APD_lst = zeros(1,N);
    TT_lst = zeros(1,N);
    
    for k=1:N
        [~,APD_lst(k),~,TT_lst(k)] = simulator2(lambda(i),C,f,P,b);
    end

    % Calculate Average Packet Delay for lambda(i)
    Sim_APD(i) = mean(APD_lst);

    % Calculate Throughput for lambda(i)
    Sim_TT(i) = mean(TT_lst);
    
    % Calculate M/M/1 and M/G/1 theoretical values
    MM1_TT(1,i) = size * lambda(i) * 10^(-6);
    MM1_Theoretical_APD(1,i) = Theoretical_APD_MM1(lambda(i),C,size) * 1000;
    [PL,MM1_Theoretical_APD(2,i),MM1_TT(2,1)] = MG1(b,lambda(i),C);
    
end

APD = [Sim_APD; MM1_Theoretical_APD];

% Bar 1 - Average Packet Delay
figure(1)
bar(lambda, APD)
xlabel('λ (requests/hour)')
title('Average Packet Delay (milliseconds)')
legend({'Simulation','M/M/1','M/G/1'},'Location','northwest')
hold on
grid on

TT = [Sim_TT; MM1_TT];

% Bar 2 - Transmit Throughput
figure(2)
bar(lambda, TT)
xlabel('λ (requests/hour)')
title('Transmitted Throughput (Mbps)')
legend({'Simulation','M/M/1','M/G/1'},'Location','northwest')
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

function MM1_APD = Theoretical_APD_MM1(lambda,C,size)
    m = (C*10^6)/size;
    MM1_APD = 1/(m-lambda);
end

function [PL,APD,TT] = MG1(ber,lambda,C)
    sum = 0;

    B = [64:1518];
    [~,c] = size(B);

    p1 = (0.39/((109 - 65 + 1)+(1517 - 111 + 1)));
    p = 0;
    es = 0;
    es2 = 0;
    Pi = (1 - ber).^(8.*B);
    for i = 1:c
        Pi = (1 - ber)^(8*B(i));
        if B(i)== 64
            p = 0.16;
        elseif B(i)== 110
            p = 0.25;
        elseif B(i)== 1518
            p = 0.2;
        else
            p = p1;
        end
        sum = sum + p*(1-Pi);
        es = es + (p*((8*B(i))/(C*10^6)));
        es2 = es2 + (p*((8*B(i))/(C*10^6))^2);
    end

    PL = 100 * sum;
    WQ = (lambda*es2)/(2*(1-lambda*es));
    APD1=0;
    APD2=0;
    TT=0;
    for i = 1:c
        Pi = (1 - ber)^(8*B(i));
        if B(i)== 64
            p = 0.16;
        elseif B(i)== 110
            p = 0.25;
        elseif B(i)== 1518
            p = 0.2;
        else
            p = p1;
        end
        Wi = WQ+((8*B(i))/(C*10^6));
        APD1 = APD1 + (p*Pi*Wi);
        APD2 = APD2 + (p*Pi);
        TT=TT +(p*Pi*lambda*8*B(i));
    end
    TT = TT*10^-6;
    APD = (APD1/APD2)*1000;
end 
