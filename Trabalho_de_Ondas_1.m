%------------------------------------------------------------------------%
%----------------- Trabalho 1 de Ondas SEL0312---------------------------%
%------------------------------------------------------------------------%
% ----------- Membros ------------- %
% Gabriela Barion Vidal ----------- %
% Rodrigo Bragato Piva ------------ %
% Pedro Ramos Cunha --------------- %

clc
close all
clear all

%------------------------------- Definições iniciais para o sistema FDTD ------------------------%

dv    =   10;               % delta v entre os pontos do eixo da tensao    (em milimetros)
Nv    =   100;             % numero de pontos do eixo da tensao
dz    =   10;                % delta t entre cada pontos                    (em nano segundos)
Nz    =   100;              % numero de pontos do eixo do tempo			


Z     =   (0:Nz-1)*dz;      % vetor das absissas
T     =   (0:Nv-1)*dv;      % vetor das ordenadas

%-------------------------------- Declaração de variáveis ----------------------------------------%

mu0   =   2.013354451e-4;     % permissividade no vacuo em (V fs^2/e nm)
ep0   =   55.26349597e-3;     % permissividade no vacuo em (e / V nm)



























%--------------------------------- areaagem -------------------------------------%

	figure('Name','Valores de tensão e corrente na Linha de transmissão para Fonte 1','NumberTitle','off');
for n=1:length(t)
	tiledlayout(3,2) % Requires R2019b or later


	%Fonte 1 Rl = infinito
	nexttile
	area(Z,V1,'r','LineWidth',3)%Grafico da tensao 
	title('Tensão para Rl=inf')
	xlabel('dz(cm)')
	ylabel('dv(v)')
	grid on
	grid minor
	nexttile
	area(Z,I1,'b','LineWidth',3)	%Grafico da corrente 
	title('Corrente para Rl=inf')
	xlabel('dz(cm)')
	ylabel('i(A)')
	grid on
	grid minor

	%Fonte 2 Rl = infinito
	nexttile
	area(Z,V2,'r','LineWidth',3)	%Grafico da tensao
	title('Tensão para Rl=inf')
	xlabel('dz(cm)')
	ylabel('dv(v)') 
	grid on
	grid minor
	nexttile
	area(Z,I2,'b','LineWidth',3)	%Grafico da corrente
	title('Corrente para Rl=inf')
	xlabel('dz(cm)')
	ylabel('i(A)')
	grid on
	grid minor

	%Fonte 1 Rl = 0
	nexttile
	area(Z,V3,'r','LineWidth',3)	%Grafico da tensao 
	title('Tensão para Rl=0')
	xlabel('dz(cm)')
	ylabel('dv(v)')
	grid on
	grid minor
	nexttile
	area(Z,I3,'b','LineWidth',3)	%Grafico da corrente 
	title('Corrente para Rl=0')
	xlabel('dz(cm)')
	ylabel('i(A)')
	grid on
	grid minor
	getframe();

end

	
figure('Name','Valores de tensão e corrente na Linha de transmissão para fonte 2','NumberTitle','off');
for n=1:length(t)
	tiledlayout(3,2) % Requires R2019b or later
	%Fonte 2 Rl = 0
	nexttile
	area(Z,V4,'r','LineWidth',3)	%Grafico da tensao
	title('Tensão p/ Rl=0')
	xlabel('dz(cm)')
	ylabel('dv(v)') 
	grid on
	grid minor
	nexttile
	area(Z,I4,'b','LineWidth',3)	%Grafico da corrente 
	title('Corrente p/ Rl=0')
	xlabel('dz(cm)')
	ylabel('i(A)')
	grid on
	grid minor


	%Fonte 1 Rl = 100
	nexttile
	area(Z,V5, 'r','LineWidth',3)	%Grafico da tensao
	title('Tensão para Rl=100')
	xlabel('dz(cm)')
	ylabel('dv(v)') 
	grid on
	grid minor
	nexttile
	area(Z,I6,'b','LineWidth',3)	%Grafico da corrente
	title('Corrente para Rl=100')
	xlabel('dz(cm)')
	ylabel('i(A)')
	grid on
	grid minor

	%Fonte 2 Rl = 100
	nexttile
	area(Z,V6, 'r','LineWidth',3)	%Grafico da tensao 
	title('Tensão p/ Rl=100')
	xlabel('dz(cm)')
	ylabel('dv(v)')
	grid on
	grid minor 
	nexttile
	area(Z,I6,'b','LineWidth',3)	%Grafico da corrente
	title('Corrente p/ Rl=100')
	xlabel('dz(cm)')
	ylabel('i(A)')
	grid on
	grid minor 

	getframe();
end



