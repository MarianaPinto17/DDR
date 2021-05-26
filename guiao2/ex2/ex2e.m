% e)

R = 100000;
S = 10000;
p = 24;
lambda = 100000/24;
fname = 'movies.txt';
alfa=0.1;

n = 6;
W = 0;

while 1
    for n=5:6
        for W=0:10
            % Run simulators
            [blocking_hd, blocking_4k] = simulator2(lambda,p,n,S,W,R,fname);
            [blocking_hd_2, blocking_4k_2] = simulator2(lambda,p,n-1,S,W,R,fname);

            % If both blocking probabilities +- confidence values are <= 1,
            % Bingo!
            if blocking_hd <= 0.1 && blocking_hd_2 <= 1
                if blocking_4k <= 0.1 && blocking_4k_2 <= 1
                    fprintf("\nn=%d\n", n);
                    fprintf("W=%d\n", W);
                    fprintf("HD Blocking Probability1=%f%%\n", blocking_hd);
                    fprintf("4K Blocking Probability1=%f%%\n", blocking_4k);
                    fprintf("HD Blocking Probability2=%f%%\n", blocking_hd_2);
                    fprintf("4K Blocking Probability2=%f%%\n", blocking_4k_2);
                    break
                end
            end
        end
    end
end

% Resultado
% Correndo o script temos que n=6 e W=0.
