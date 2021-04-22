% Ex1
% a)

N = 10;
lambda = 20;
R = 500;
C = 100;
M = 4;
alfa = 0.1;
fname = 'movies.txt';

block = zeros(1,N);
occup = zeros(1,N);

for i=1:N
    [block(i),occup(i)] = simulator1(lambda,C,M,R,fname);
end

% Calculate blocking probability
blockProb = mean(block);
term = norminv(1-alfa/2)*sqrt(var(block)/N);
fprintf('Blocking probability(%%)= %.2e +-%.2e\n',blockProb,term);

% Calculate average occupation
avgOccup = mean(occup);
term = norminv(1-alfa/2)*sqrt(var(occup)/N);
fprintf('Average occupation(Mbps)= %.2e +-%.2e\n',avgOccup,term);

% b)

lambda = [10, 15, 20, 25, 30, 35, 40];

blockingProb = zeros(1,length(lambda));
termBlocking = zeros(1, length(lambda));
avgOccup = zeros(1,length(lambda));
termOccup = zeros(1, length(lambda));

for x=1:length(lambda)
    block = zeros(1,N);
    occup = zeros(1,N);
    for i=1:N
        [block(i),occup(i)] = simulator1(lambda(x),C,M,R,fname);
    end
    
    % Blocking probability
    blockingProb(x) = mean(block);
    termBlocking(x) = norminv(1-alfa/2)*sqrt(var(block)/N);

    
    % Server occupation
    avgOccup(x) = mean(occup);
    termOccup(x) = norminv(1-alfa/2)*sqrt(var(occup)/N);
end

% Bar 1 - Blocking probability
figure(1)
bar(lambda, blockingProb)
xlabel('λ (requests/hour)')
hold on
err = errorbar(lambda, blockingProb, termBlocking, termBlocking);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

% Bar 2 - Average server occupation
figure(2)
bar(lambda, avgOccup)
hold on
err = errorbar(lambda, avgOccup, termOccup, termOccup);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

% c)
R = 5000;
blockingProb = zeros(1,length(lambda));
termBlocking = zeros(1, length(lambda));
avgOccup = zeros(1,length(lambda));
termOccup = zeros(1, length(lambda));

for x=1:length(lambda)
    block = zeros(1,N);
    occup = zeros(1,N);
    for it= 1:N
        [block(it),occup(it)] = simulator1(lambda(x),C,M,R,fname);
    end
    
    % Blocking probability
    blockingProb(x) = mean(block);
    termBlocking(x) = norminv(1-alfa/2)*sqrt(var(block)/N);

    
    % Server occupation
    avgOccup(x) = mean(occup);
    termOccup(x) = norminv(1-alfa/2)*sqrt(var(occup)/N);
end

% Bar 1 - Blocking probability
figure(3)
bar(lambda, blockingProb)
xlabel('λ (requests/hour)')
hold on
err = errorbar(lambda, blockingProb, termBlocking, termBlocking);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

% Bar 2 - Average server occupation
figure(4)
bar(lambda, avgOccup)
hold on
err = errorbar(lambda, avgOccup, termOccup, termOccup);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off
