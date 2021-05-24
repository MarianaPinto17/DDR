function [b o]= simulator1(lambda,s,p,R,n,w,fname)
    %lambda = request arrival rate (in requests per hour)
    %C=       Internet connection capacity (in Mbps)
    %R=       stop simulation on ARRIVAL no. R
    %fname=   filename with the duration of each movie
    %p=       prob of a request are for 4K movies
    %n=       number of servers
    %w=       number of Mbps reserved
    %HD=      HD video format - throughput of 5Mbps
    %FK=      4k video format - throughput of 25MBps;
    
    invlambda=60/lambda;     %average time between requests (in minutes)
    invmiu= load(fname);     %duration (in minutes) of each movie
    Nmovies= length(invmiu); % number of movies
    
    C = n*s;
    HD = 5;
    FK = 25;
    
    %Events definition:
    ARRIVAL= 0;        %movie request
    DEPARTURE=1;
    %DEPARTURE_HD= ;      %termination of a movie transmission
    %DEPARTURE_4K=;
    %State variables initialization:
    STATE= zeros(n);
    %Statistical counters initialization:
    REQUESTS_HD=0;
    REQUESTS_4K=0;
    BLOCKED_HD=0;
    BLOCKED_4K=0;
    %Simulation Clock and initial List of Events:
    Clock= 0;
    EventList= [ARRIVAL exprnd(invlambda)];
    
    while REQUESTS_HD + REQUESTS_4K < R
        %returns a pseudorandom scalar integer between 0 and 100.
        rand = randi([0,100]);
        % rand < prob of a request are for 4K movies
        if rand>p
            M=HD;
            REQUESTS = REQUESTS_HD;
        else
            M=FK;
        end
        id = 1;
        event= EventList(1,1);
        Previous_Clock= Clock;
        Clock= EventList(1,2);
        EventList(1,:)= [];
        min = R;
        if event == ARRIVAL
            EventList= [EventList; ARRIVAL Clock+exprnd(invlambda)];
            REQUESTS= REQUESTS+1;
            if STATE(id) + M <= s
                STATE(id) = STATE(id)+M;
                EventList= [EventList; DEPARTURE Clock+invmiu(randi(Nmovies))];
            else
                if rand > p
                    BLOCKED_HD= BLOCKED_HD+1;
                else
                    BLOCKED_4K=BLOCKED_4K+1;
                end
            end
        else
            STATE(id)=STATE(id)-M;
        end
        EventList= sortrows(EventList,2);
        if x > p
            REQUESTS_HD = REQUESTS;
        else
            REQUESTS_4K = REQUESTS;
        end
    end
    % blocking probability of HD movie requests    
    bhd = 100*BLOCKED_HD/REQUESTS_HD;
    % blocking probability of 4K movie requests
    b4k = 100 * BLOCKED_4K/RESQUESTS_4K;
end
 