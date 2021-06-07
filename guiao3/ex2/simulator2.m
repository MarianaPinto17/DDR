function [PL , APD , MPD , TT] = simulator2(lambda,C,f,P,b)
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

%State variables:
STATE = 0;          % 0 - connection free; 1 - connection bysy
QUEUEOCCUPATION= 0; % Occupation of the queue (in Bytes)
QUEUE= [];          % Size and arriving time instant of each packet in the queue

%Statistical Counters:
TOTALPACKETS= 0;       % No. of packets arrived to the system
LOSTPACKETS= 0;        % No. of packets dropped due to buffer overflow
TRANSMITTEDPACKETS= 0; % No. of transmitted packets
TRANSMITTEDBYTES= 0;   % Sum of the Bytes of transmitted packets
DELAYS= 0;             % Sum of the delays of transmitted packets
MAXDELAY= 0;           % Maximum delay among all transmitted packets
PISUM = 0;

%Auxiliary variables:
% Initializing the simulation clock:
Clock= 0;

% Initializing the List of Events with the first ARRIVAL:
EventList = [ARRIVAL, Clock + exprnd(1/lambda), GeneratePacketSize(), 0];

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
            EventList = [EventList; ARRIVAL, Clock + exprnd(1/lambda), GeneratePacketSize(), 0];
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
        case DEPARTURE                     % If first event is a DEPARTURE
            % The probability of each packet size 𝐵𝑖 being sent without 
            % errors is:
            % Pi = (1 - b) ^ (8 * PacketSize)
            % So, the packet loss (in %) is the weighted sum of the packet 
            % loss probability of each packet size, where the weights 
            % are the probabilities of the packet sizes
            Pi = (1-b)^(8*PacketSize);
            r = rand();
            
            if (r < Pi) % with errors
                PISUM = PISUM * (Pi*(1-Pi));
            else % without errors
                TRANSMITTEDBYTES= TRANSMITTEDBYTES + PacketSize;
                DELAYS= DELAYS + (Clock - ArrivalInstant);
                if Clock - ArrivalInstant > MAXDELAY
                    MAXDELAY= Clock - ArrivalInstant;
                end
                TRANSMITTEDPACKETS= TRANSMITTEDPACKETS + 1;
            end
            %
            if QUEUEOCCUPATION > 0
                EventList = [EventList; DEPARTURE, Clock + 8*QUEUE(1,1)/(C*10^6), QUEUE(1,1), QUEUE(1,2)];
                QUEUEOCCUPATION= QUEUEOCCUPATION - QUEUE(1,1);
                QUEUE(1,:)= [];
            else
                STATE= 0;
            end
    end
end

%Performance parameters determination:
%PL= 100*LOSTPACKETS/TOTALPACKETS;      % in %
PL=100*PISUM;
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