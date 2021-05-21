% EXERCISE 2
% Develop a MATLAB script to run 10 times simulator2 with a stopping criterion of R = 10000
% and to compute the estimated values and the 90% confidence intervals of both blocking
% probabilities. Consider Configuration 1 for  = 100, 120, 140, 160, 180 and 200 requests/hour,
% p = 20%, and a resource reservation W = 0 Mbps. Present the results and the confidence intervals
% in bar charts with error bars. Analyse the results and take conclusions on (i) the impact of the
% arriving rate  of the movie requests in the blocking probability of each movie format and (ii)
% if the stopping criterion value is large enough or should be larger.


fname = "movies.txt";
lambda = linspace(100,200,6);
b = zeros(2,6);
for i = 1:6
    %lambda,S,p,R,n,w,fname
    [b(1,i) b(2,i)] = simulator2(lambda(i),100,20,10000,10,0,fname);
end

figure
bar(lambda, b);
hold on

xlabel('Lambda');
ylabel('P(%)');
title('A Blocking Probability (%)');
grid on