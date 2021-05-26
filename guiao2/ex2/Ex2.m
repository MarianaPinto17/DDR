% Ex2
% a)

N = 10;
R = 10000;
alfa = 0.1;
% Configuration 1: n = 10, S = 100 Mbps
n = 10;
S = 100;
p = 20;
W = 0;
lambda = [100, 120, 140, 160, 180, 200];
fname = 'movies.txt';

blockingProbHD = zeros(1,length(lambda));
termHD = zeros(1,length(lambda));
blockingProb4K = zeros(1,length(lambda));
term4K = zeros(1,length(lambda));

for x=1:length(lambda)
    b_hd = zeros(1,N);
    b_4k = zeros(1,N);
    
    for i=1:N
        [b_hd(i),b_4k(i)] = simulator2(lambda(x),p,n,S,W,R,fname);
    end
    
    % Blocking probability (HD)
    blockingProbHD(x) = mean(b_hd);
    termHD(x) = norminv(1-alfa/2)*sqrt(var(b_hd)/N);
    
    % Blocking probability (4K)
    blockingProb4K(x) = mean(b_4k);
    term4K(x) = norminv(1-alfa/2)*sqrt(var(b_4k)/N);
    
end

% Bar 1 - Blocking probability (HD)
figure(1)
bar(lambda, blockingProbHD)
title("Blocking Probability (HD)")
xlabel('λ (requests/hour)')
ylabel('%')
hold on
err = errorbar(lambda, blockingProbHD, termHD, termHD);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

% Bar 2 - Blocking probability (4K)
figure(2)
bar(lambda, blockingProb4K)
title("Blocking Probability (4K)")
xlabel('λ (requests/hour)')
ylabel('%')
hold on
err = errorbar(lambda, blockingProb4K, term4K, term4K);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off



