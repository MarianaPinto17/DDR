% Ex3
% c)

TIER_2_SUBS = 5000;
TIER_3_SUBS = 2500;
SUBS_TOTAL = TIER_2_SUBS * 10 + TIER_3_SUBS * 25;

% N => número de servidores calculados na alínea b)
N = 76;

% ASs calculated in a)
% ==> 10, 13, 16, 21, 30

% Dado que os ASs escolhidos vão comunicar apenas com os servidores que
% estão no máximo a um salto de distância, podemos considerar a
% distribuição seguinte:

% 10 => 9(5000 subscritores), 10(5000 subscritores), 11(5000/2
% subscritores), 22(2500/2 subscritores), 23(2500 subscritores), 24(2500
% subscritores), 25(2500 subscritores), 26(2500 subscritores), 27(2500
% subscritores), 28(2500/2 subscritores), 29(2500/2 subscritores)
AS_10 = 5000*2 + 2500*6 + 1250*3;

% 13 => 13(5000 subscritores), 14(5000 subscritores), 33(2500
% subscritores), 34(2500 subscritores), 35(2500 subscritores), 36(2500
% subscritores), 37(2500 subscritores), 38(2500 subscritores)
AS_13 = 5000*2 + 2500*6;

% 16 => 6(5000 subscritores), 7(5000/2 subscritores), 15(5000
% subscritores), 16(5000/2 subscritores), 17(2500 subscritores), 18(2500
% subscritores), 19(2500 subscritores), 39(2500 subscritores), 40(2500
% subscritores)
AS_16 = 5000*2 + 2500*7;

% 21 => 7(5000/2 subscritores), 8(5000 subscritores), 20(2500
% subscritores), 21(2500 subscritores), 22(2500/2 subscritores)
AS_21 = 5000 + 2500*3 + 1250;

% 30 => 11(5000/2 subscritores), 12(5000 subscritores), 28(2500/2
% subscritores), 29(2500/2 subscritores), 30(2500 subscritores), 31(2500
% subscritores), 32(2500 subscritores)
AS_30 = 5000 + 2500*4 + 1250*2;

% Cálculo da percentagem de carga em cada servidor selecionado:
LOAD_10 = AS_10/SUBS_TOTAL;
LOAD_13 = AS_13/SUBS_TOTAL;
LOAD_16 = AS_16/SUBS_TOTAL;
LOAD_21 = AS_21/SUBS_TOTAL;
LOAD_30 = AS_30/SUBS_TOTAL;

% Cálculo do número de servidores, considerando cada uma das cargas:
NS_10 = round(N * LOAD_10);
NS_13 = round(N * LOAD_13);
NS_16 = round(N * LOAD_16);
NS_21 = round(N * LOAD_21);
NS_30 = round(N * LOAD_30);

fprintf("\nAS 10: %d\n", NS_10);
fprintf("AS 13: %d\n", NS_13);
fprintf("AS 16: %d\n", NS_16);
fprintf("AS 21: %d\n", NS_21);
fprintf("AS 30: %d\n", NS_30);

TOTAL_NS = (NS_10 + NS_13 + NS_16 + NS_21 + NS_30) == N

% Concluímos então que tem-se 19 servidores no AS 10, 17 servidores no AS 13,
% 19 servidores no AS 16, 9 servidor no AS 21 e 12 servidores no AS 30
