% e)

R = 100000;
S = 10000;
p = 24;
lambda = 100000/(7*24);
fname = 'movies.txt';
n = 2;
W = 0;
alfa=0.1;

% Init matrixes
blocking_hd = zeros(1,10);
blocking_4k = zeros(1,10);
blocking_hd_2 = zeros(1,10);
blocking_4k_2 = zeros(1,10);

% Run simulator2 10 times
for i=1:10
    [blocking_hd(i), blocking_4k(i)] = simulator2(lambda,p,n,S,W,R,fname)
end
for i=1:10
    [blocking_hd_2(i), blocking_4k_2(i)] = simulator2(lambda,p,n-1,S,W,R,fname)
end

% Calculate blocking probability of HD
blocking_prob_hd = mean(blocking_hd);
confidence_hd = norminv(1-alfa/2)*sqrt(var(blocking_hd)/10);
blocking_prob_hd_2 = mean(blocking_hd_2);
confidence_hd_2 = norminv(1-alfa/2)*sqrt(var(blocking_hd_2)/10);

% Calculate blocking probability of 4K
blocking_prob_4k = mean(blocking_4k);
confidence_4k = norminv(1-alfa/2)*sqrt(var(blocking_4k)/10);
blocking_prob_4k_2 = mean(blocking_4k_2);
confidence_4k_2 = norminv(1-alfa/2)*sqrt(var(blocking_4k_2)/10);

% If both blocking probabilities +- confidence values are <= 1,
% Bingo!
if blocking_prob_hd - confidence_hd <= 0.1 && blocking_prob_hd_2 + confidence_hd_2 <= 1
    if blocking_prob_4k - confidence_4k <= 0.1 && blocking_prob_4k_2 + confidence_4k_2 <= 1
        fprintf("\nn=%d\n", n);
        fprintf("W=%d\n", W);
        fprintf("HD Blocking Probability=%f%%\n", blocking_prob_hd);
        fprintf("HD confidence=%f%%\n", confidence_hd);
        fprintf("4K Blocking Probability=%f%%\n", blocking_prob_4k);
        fprintf("4K confidence=%f%%\n", confidence_4k);
    end
end
