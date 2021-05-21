% EXERCISE 1
% 1.a) Develop a MATLAB script to run simulator1 10 times with a stopping criterion of R = 500 at
% each run and to compute the estimated values and the 90% confidence intervals of both
% performance parameters (see Module3, slide 22, of theoretical classes) when lambda = 20
% requests/hour, C = 100 Mbps and M = 4 Mbps.

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

% 1.b) Develop a MATLAB script to run simulator1 10 times with a stopping criterion of R = 500 and
% to compute the estimated values and the 90% confidence intervals of both performance
% parameters when  = 10, 15, 20, 25, 30, 35 and 40 requests/hour, C = 100 Mbps and M = 4
% Mbps. Present the results and the confidence intervals in bar charts with error bars 1 .

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

% 1.c) Repeat question 1.b but consider now a stopping criterion of R = 5000 (10 times higher than the
% previous value). Present again the results in bar charts with error bars. Compare the obtained
% confidence intervals of these and the last results and take conclusions.
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

% 1.d) Run simulator1 10 times with a stopping criterion of R = 5000 to compute the estimated values
% and the 90% confidence intervals of both performance parameters when  = 100, 150, 200, 250,
% 300, 350 and 400 requests/hour, C = 1000 Mbps and M = 4 Mbps. Present again the results in
% bar charts with error bars. With these results and the results of previous question 1.c, take
% conclusions on the impact of the input parameters on the performance parameters.


% 1.e) Assume that the duration of the movies is an exponential distributed random variable with the
% same average duration of the items catalogue, i.e., 1/  = 86.3 minutes. In this case, the system
% can be modelled by an M/M/m/m queuing system. Determine the analytical values of the
% blocking probability and the average connection occupation (see Appendix B) for the cases
% considered in question 1.c. Present both theoretical and simulation results in bar charts. Is the
% M/M/m/m queuing system a good approximation of the simulated system?

N_teorico = C/M;
for z = 1:sz
   ro = (lambda_values(z)/3600)*inverse_mu;
   
   b_teoricos(z) = theoricalBlockingProbability(ro, N_teorico);
   o_teoricos(z) = theoricalAverageSystemOccupation(ro, N_teorico);
   
   b_mixed(1,z) = medias_b(z);
   b_mixed(2,z) = b_teoricos(z)*100;
   o_mixed(1,z) = medias_o(z);
   o_mixed(2,z) = o_teoricos(z)*M;
end
