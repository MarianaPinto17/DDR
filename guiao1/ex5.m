% Exercise: Consider again the wireless link between two stations of the 
% previous Task 4. 
% Consider now that the two stations run an interference detection system 
% that works as follows: the stations exchange from time to time a set of n 
% consecutive control frames (each frame with a size of B = 64 Bytes) and 
% the stations decide that the link:
%   - is in the interference state when all n control frames are received 
%   with errors and
%   - is in the normal station if at least one of the n control frames is 
%   received without errors.

% Consider the following definitions:
%   - a false positive is when a station decides wrongly that the link is in 
%   interference state (i.e., it receives the n control frames with error and 
%   the link is in the normal state)
%   - a false negative is when a station decides wrongly that the link is in 
%   the normal state (i.e., at least one of the n control frames is received 
%   without errors and the link is in the interference state)

% 5.a. Draw a plot using a logarithmic scale for the Y-axis (use the MATLAB 
% function semilogy) with the probability of false positives for n = 2, 3, 
% 4 and 5. Analyze and justify the results.


% 5.b. Draw a plot with the probability of false negatives for n = 2, 3, 4 
% and 5. Analyze and justify the results.


% 5.c. Assume that the probabilities of false positives and false negatives
% are equally important in the accuracy of the interference detection system. 
% From the plots obtained in 5.a and 5.b, determine the best value of n to 
% be used by the system. Justify your answer.
