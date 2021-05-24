%% List of pairs of connected ASs
G= [ 1 2
1 3
1 4
1 5
1 6
1 14
1 15
2 3
2 4
2 5
2 7
2 8
3 4
3 5
3 8
3 9
3 10
4 5
4 10
4 11
4 12
4 13
5 12
5 13
5 14
6 7
6 16
6 17
6 18
6 19
7 19
7 20
8 9
8 21
8 22
9 10
9 22
9 23
9 24
9 25
10 11
10 26
10 27
11 27
11 28
11 29
11 30
12 30
12 31
12 32
13 14
13 33
13 34
13 35
14 36
14 37
14 38
15 16
15 39
15 40
20 21];

% Visualise graph
figure(1)
s = G(:,1);
t = G(:,2);
D = graph(s,t);
p = plot(D);

% Generate sets of I
I = generateSetI(G,6,40);

% From the guide: "The cost of the Internet connection of a server farm is 12 
% when the connection is provided by a Tier-2 AS and 8 when 
% the connection is provided by a Tier-3 AS."
c = [repelem(12, 10) repelem(8, 25)];
n = length(c);

% Generate LP file
generateLP('servers_ilp_script.lp',I,c,n)


%% Resultados
% Atendendo ao resultados obtidos deste problema ILP, conclui-se que o
% custo total das ligações internet é de 48.
% São necessários 6 servidores sendo eles os seguintes.
% {10, 13, 16, 21, 30}


%% Exercise 3 functions
function I = generateSetI(G, startNode, nNodes)
    %G = AS pairs matrix
    %startNode = start node
    %nNodes = number of nodes
    
    % Generate graph
    s = G(:,1);
    t = G(:,2);
    D = graph(s,t);
    
    % Initialize an array to represent distance between AS's
    % Initialize it with -1 (representing more than 2 jumps) 
    % Other possoble values are 0(itself), 1/2 (1 or 2 jumps)
    M = -1*ones(nNodes,nNodes);
    
    % Loop through nodes (starting on startNode) and using
    % shortestpath() function, retrieve d (distance)
    % If d<=2, set the corresponding value on matrix M
    for i=startNode:nNodes
        for j=1:nNodes
            [~,d] = shortestpath(D,i,j);
            if d <= 2
                M(i,j) = d;
            end
        end
    end
    
    % Filters M matrix in order to discard nodes that are more
    % than two jumps away
    T = (M >=0 & M <=2);
    
    % Filters T matrix in order to obtain nodes that are 1 or 2
    % jumps away
    [N1, N2] = find(T>0);
    I = [N1, N2];
    
    % Discard Tier-1 connections
    I = I(I(:, 1)>5, :);
    I = I(I(:, 2)>5, :);
    
    % Sort rows by first column
    I = sortrows(I, 1);
end

function generateLP(fname,I,c,n)
    %fname = output filename
    %I = matrix of I sets
    %c = matrix of ASs internet costs
    %n = number of ASs
    
    fid = fopen(fname,'wt');
    fprintf(fid,'Minimize\n');
    
    for i=1:n
        fprintf(fid,' + %d x%d',c(i),i+5);
    end

    fprintf(fid,'\nSubject To\n');
    
    tPast = -1;
    for j=1:size(I, 1)
        tActual = I(j, 1);
        if (tPast ~= tActual && tPast ~= -1)
            fprintf(fid,' >= 1\n');
        end
        fprintf(fid,' + x%d', I(j, 2));

        tPast = I(j, 1);
    end
    
    fprintf(fid,' = 1\n');

    fprintf(fid,'Binary\n');

    for i=1:n
        fprintf(fid,' x%d\n',i+5);
    end

    fprintf(fid,'End\n');
    fclose(fid);
end
