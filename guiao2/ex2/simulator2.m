function [B_HD B_4K] = simulator2(lambda,p,n,S,W,R,fname)
    %lambda = movies request rate (in requests/hour)
    %p = percentage of requests for 4K movies (in %)
    %n = number of servers
    %S = interface capacity of each server(in Mbps)
    %W = resource reservation for 4K movies(in Mbps)
    %R = number of movie requests to stop simulation
    %fname = file name with the duration (in minutes) of the items

    invlambda = 60/lambda;
    invmiu = load(fname);
    Nmovies = length(invmiu);
    C = n * S;

    THROUGHPUT_HD = 5;
    THROUGHPUT_4K = 25;

    % Events definition
    ARRIVAL = 0;
    DEPARTURE_HD = 1;
    DEPARTURE_4K = 2;

    % State variables
    STATE = zeros(1,n);
    STATE_HD = 0;

    % Statistical counters
    NARRIVALS = 0;
    REQUESTS_HD = 0;
    REQUESTS_4K = 0;
    BLOCKED_HD = 0;
    BLOCKED_4K = 0;

    % Simulation Clock and initial List of events
    Clock = 0;
    EventList = [ARRIVAL exprnd(invlambda) 0];

    while NARRIVALS < R
        event = EventList(1,1);
        Clock = EventList(1,2);
        serverIDX = EventList(1,3);
        EventList(1,:) = [];
        
        if event == ARRIVAL
            EventList = [EventList; ARRIVAL Clock+exprnd(invlambda) 0];
            NARRIVALS = NARRIVALS + 1;
            r = rand()*100;
            if r < p
                REQUESTS_4K = REQUESTS_4K + 1;
                
                % Find least loaded server
                %[lixo idx] = findLeastLoadedServer(STATE, N);
                [M idx] = min(STATE);
                
                if STATE(idx) + THROUGHPUT_4K <= S
                    STATE(idx) = STATE(idx) + THROUGHPUT_4K;
                    EventList = [EventList; DEPARTURE_4K Clock+invmiu(randi(Nmovies)) idx];
                else
                    BLOCKED_4K = BLOCKED_4K + 1;
                end
            else
                REQUESTS_HD = REQUESTS_HD + 1;
                
                % Find least loaded server
                [M idx] = min(STATE);
                
                if (STATE(idx)+ THROUGHPUT_HD <= S) && (STATE_HD < C - W)
                    STATE(idx) = STATE(idx) + THROUGHPUT_HD;
                    STATE_HD = STATE_HD + THROUGHPUT_HD;
                    EventList = [EventList; DEPARTURE_HD Clock+invmiu(randi(Nmovies)) idx];
                else
                    BLOCKED_HD = BLOCKED_HD + 1;
                end
            end
        elseif event == DEPARTURE_4K
            STATE(serverIDX) = STATE(serverIDX) - THROUGHPUT_4K;
        elseif event == DEPARTURE_HD
            STATE(serverIDX) = STATE(serverIDX) - THROUGHPUT_HD;
            STATE_HD = STATE_HD - THROUGHPUT_HD;
        end
        EventList= sortrows(EventList,2);
    end
    
    B_HD = 100*BLOCKED_HD/REQUESTS_HD;
    B_4K = 100*BLOCKED_4K/REQUESTS_4K;
end
