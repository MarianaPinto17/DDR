function [PL , APD , MPD , TT] = simulator3(lambda,C,f,P,b)
% INPUT PARAMETERS:
%  lambda - packet rate (packets/sec)
%  C      - link bandwidth (Mbps)
%  f      - queue size (Bytes) using FIFO - FIRTS IN FIRST OUT
%  P      - number of packets (stopping criterium)
%  b      - BER 
% OUTPUT PARAMETERS:
%  PL   - packet loss (%)
%  APD  - average packet delay (milliseconds)
%  MPD  - maximum packet delay (milliseconds)
%  TT   - transmitted throughput (Mbps)

%Events:
ARRIVAL= 0;       % Arrival of a packet            
DEPARTURE= 1;     % Departure of a packet
TRANSITION= 2;    % Transition of a packet

%State variables:
STATE = 0;          % 0 - connection free; 1 - connection bysy
QUEUEOCCUPATION= 0; % Occupation of the queue (in Bytes)
QUEUE= [];          % Size and arriving time instant of each packet in the queue
FLOWSTATE= 0;       % Current state of the packet (1,2,3)

%Statistical Counters:
TOTALPACKETS= 0;       % No. of packets arrived to the system
LOSTPACKETS= 0;        % No. of packets dropped due to buffer overflow
TRANSMITTEDPACKETS= 0; % No. of transmitted packets
TRANSMITTEDBYTES= 0;   % Sum of the Bytes of transmitted packets
DELAYS= 0;             % Sum of the delays of transmitted packets
MAXDELAY= 0;           % Maximum delay among all transmitted packets

%Auxiliary variables:
% Initializing the simulation clock:
Clock= 0;

% Markov Chain probabilities and average times
P1 = 1/(1+(10/5)+(10/5)*(5/10));
P2 = (10/5)/(1+(10/5)+(10/5)*(5/10));
P3 = (10/5)*(5/10)/(1+(10/5)+(10/5)*(5/10));

T1 = (1/10);
T2 = (1/(5+5));
T3 = (1/10);

% Average time duration array
T = [T1,T2,T3];

% Flow rate
FLOW = [0.5*lambda, lambda, 1.5*lambda];

% Find initial FLOWSTATE
r = rand();
if r < P1
    FLOWSTATE = 1;
elseif r >= P1 && r < (P1+P2)
    FLOWSTATE = 2;
else
    FLOWSTATE = 3;
end

% Initializing the List of Events with the first ARRIVAL:
EventList = [ARRIVAL, Clock + exprnd(1/FLOW(FLOWSTATE)), GeneratePacketSize(), 0];

% Update the event List with TRANSITION
EventList = [EventList; TRANSITION, Clock + exprnd(T(FLOWSTATE)), 0, 0];

%Similation loop:
while TRANSMITTEDPACKETS<P               % Stopping criterium
    EventList= sortrows(EventList,2);    % Order EventList by time
    Event= EventList(1,1);               % Get first event and 
    Clock= EventList(1,2);               %   and
    PacketSize= EventList(1,3);          %   associated
    ArrivalInstant= EventList(1,4);      %   parameters.
    EventList(1,:)= [];                  % Eliminate first event
    switch Event
        case ARRIVAL                     % If first event is an ARRIVAL
            TOTALPACKETS= TOTALPACKETS+1;
            EventList = [EventList; ARRIVAL, Clock + exprnd(1/FLOW(FLOWSTATE)), GeneratePacketSize(), 0];
            if STATE==0
                STATE= 1;
                EventList = [EventList; DEPARTURE, Clock + 8*PacketSize/(C*10^6), PacketSize, Clock];
            else
                if QUEUEOCCUPATION + PacketSize <= f
                    QUEUE= [QUEUE;PacketSize , Clock];
                    QUEUEOCCUPATION= QUEUEOCCUPATION + PacketSize;
                else
                    LOSTPACKETS= LOSTPACKETS + 1;
                end
            end
        case DEPARTURE % If first event is a DEPARTURE
            % The probability of each packet size 𝐵𝑖 being sent without 
            % errors is:
            % Pi = (1 - b) ^ (8 * PacketSize)
            Pi = (1-b)^(8*PacketSize);
            r = rand();
            
            if (r > Pi) % with errors
                LOSTPACKETS= LOSTPACKETS + 1;
            else % without errors
                TRANSMITTEDBYTES= TRANSMITTEDBYTES + PacketSize;
                DELAYS= DELAYS + (Clock - ArrivalInstant);
                if Clock - ArrivalInstant > MAXDELAY
                    MAXDELAY= Clock - ArrivalInstant;
                end
                TRANSMITTEDPACKETS= TRANSMITTEDPACKETS + 1;
            end
            
            if QUEUEOCCUPATION > 0
                EventList = [EventList; DEPARTURE, Clock + 8*QUEUE(1,1)/(C*10^6), QUEUE(1,1), QUEUE(1,2)];
                QUEUEOCCUPATION= QUEUEOCCUPATION - QUEUE(1,1);
                QUEUE(1,:)= [];
            else
                STATE= 0;
            end
        case TRANSITION
            if FLOWSTATE == 2 % FLOWSTATE pode ir para S1 ou s3
                r = rand();
                if r < 0.5 % TRANSITION para S1
                    FLOWSTATE = 1;
                    EventList = [EventList; TRANSITION, Clock + exprnd(T(FLOWSTATE)), 0, 0];
                else % TRANSITION para S3
                    FLOWSTATE = 3;
                    EventList = [EventList; TRANSITION, Clock + exprnd(T(FLOWSTATE)), 0, 0];
                end
            else % FLOWSTATE transita de S1->S2 ou de S3->S2
                FLOWSTATE = 2;
                EventList = [EventList; TRANSITION, Clock + exprnd(T(FLOWSTATE)), 0, 0];
            end

    end
end

%Performance parameters determination:
PL= 100*LOSTPACKETS/TOTALPACKETS;      % in %
APD= 1000*DELAYS/TRANSMITTEDPACKETS;   % in milliseconds
MPD= 1000*MAXDELAY;                    % in milliseconds
TT= 10^(-6)*TRANSMITTEDBYTES*8/Clock;  % in Mbps

end

function out= GeneratePacketSize()
    aux= rand();
    aux2= [65:109 111:1517];
    if aux <= 0.16
        out= 64;
    elseif aux <= 0.16 + 0.25
        out= 110;
    elseif aux <= 0.16 + 0.25 + 0.2
        out= 1518;
    else
        out = aux2(randi(length(aux2)));
    end
end
