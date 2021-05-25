% Ex3
% b)
R = 50000;
lambda = (5000*10+2500*25)/(7*24);
p = 30;
alfa = 0.1;
fname = 'movies.txt';
S = 1000;

% No results found for n < 12
for n=12:12
    for W=0:100
        % Init matrixes
        blocking_hd = zeros(1,10);
        blocking_4k = zeros(1,10);
        
        % Run simulator2 10 times
        for i=1:10
            [blocking_hd(i), blocking_4k(i)] = simulator2(lambda,p,n,S,W,R,fname);
        end

        % Calculate blocking probability of HD
        blocking_prob_hd = mean(blocking_hd);
        confidence_hd = norminv(1-alfa/2)*sqrt(var(blocking_hd)/10);

        % Calculate blocking probability of HD
        blocking_prob_4k = mean(blocking_4k);
        confidence_4k = norminv(1-alfa/2)*sqrt(var(blocking_4k)/10);
        
        % If both blocking probabilities +- confidence values are <= 1,
        % Bingo!
        if blocking_prob_hd - t_hd <= 1 && blocking_prob_hd + t_hd <= 1
            if blocking_prob_4k - t_4k <= 1 && blocking_prob_4k + t_4k <= 1
                fprintf("\nn=%d\n", n);
                fprintf("W=%d\n", W);
                fprintf("HD Blocking Probability=%f%%\n", blocking_prob_hd);
                fprintf("HD confidence=%f%%\n", confidence_hd);
                fprintf("4K Blocking Probability=%f%%\n", blocking_prob_4k);
                fprintf("4K confidence=%f%%\n", confidence_4k);
                break
            end
        end
    end
end
