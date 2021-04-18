% vetor x
n = linspace(64*8,200*8);

% probabilidade de um pacote chegar sem erros para P1
p = 10^-6;
se1=(1*(p^0)*((1-p).^(n-0)));

% probabilidade de um pacote chegar sem erros para P2
p = 10^-5;
se2=(1*(p^0)*((1-p).^(n-0)));

% probabilidade de um pacote chegar sem erros para P3
p = 10^-4;
se3=(1*(p^0)*((1-p).^(n-0)));

% probabilidade de um pacote chegar sem erros para P4
p = 10^-3;
se4=(1*(p^0)*((1-p).^(n-0)));

% probabilidade de um pacote chegar sem erros para P5
p = 10^-2;
se5=(1*(p^0)*((1-p).^(n-0)));

% vetores y
y4=((se4*P4)./((se1*P1)+(se2*P2)+(se3*P3)+(se4*P4)+(se5*P4)))*100
y5=((se5*P5)./((se1*P1)+(se2*P2)+(se3*P3)+(se4*P4)+(se5*P4)))*100

prob2=y4+y5

% construção gráfico
figure(2)
%vetores
plot(n/8,prob2)
%titulo
title("Probability of the link being in the normal state (package received w/o errors)")
% label x
xlabel("Packet Size (Bytes)")
% label y
ylabel("Probability(%)")
grid on