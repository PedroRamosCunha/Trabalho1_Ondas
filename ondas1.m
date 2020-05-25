%------------------------------------------------------------------------%
%----------------- Trabalho 1 de Ondas SEL0312---------------------------%
%------------------------------------------------------------------------%
% ----------- Membros ------------- %
% Gabriela Barion Vidal ----------- %
% Rodrigo Bragato Piva ------------ %
% Pedro Ramos Cunha --------------- %
close all;

%------------------------ Flags ---------------------------------------%
	
flag = 1;

%-----------------------Constantes--------------------------------------%

c  = 299792458; 					%velocidade da luz em m/s
Rs = 75;							%Resistencia antes de entrar na linha de Transmissão
C  = 7.41*10.^(-11);				%Capacitância da Linha Calculada
L  = 1.85*10.^(-7);					%Indutância da linha
%---------------------- Definição de variáveis de controle -------------%

l=1;								%distância l definida pelo grupo de 1m
aux=500;							%número de pontos de análiste ao longo da linha de transmissão
Valormax =aux;						%Tamanho máximo do vetor de armazenamento dos pontos
dz=l/aux;							%Valore dz entre os pontos discretizados para análisa
Z = linspace(0,l,aux);				%distribuição uniforme dos pontos 'dz's ao longo da linha de transmissão
uf = (0.9*c);						%valor para atingir o ponto estacionário
maxt=dz/uf;							%variável de cálculo de de tempo de dt em segundos (s)
dt = 0.9*maxt*10^(12);				%dt em nano segundo (ns)
t  = 10.^(12)*10*l/(uf);			%valor tmaximo de amostragem do FDTD
tdesliga = 10.^(12)*l/(10*uf);	
%-----------------------Constantes calculadas---------------------------%
c1 = -dt*10.^(-12)/(L*dz);						%Equação de Cálculo da Constante
c2 = 1;											%Valor da Constante Calculado
c3 = -dt*10.^(-12)/(C*dz);						%Equação de Cálculo da Constante
c4 = 1;											%Valor da constante Calculado
c5 = 2*dt*10.^(-12)/(Rs*C*dz);					%Equação de Cálculo da Constante
c6 = 2*dt*10.^(-12)/(100*C*dz);					%Equação de Cálculo da Constante
Vf1= 2;											%Valor inicial da Fonte 1
Vf2= 1; 										%Valor Inicial da Fonte 2
If1= [0 , 0.016 , 0.0089];						%Corrente inicial da corrente para Fonte 1 para os casos 1,2 e 3
If2= [0 , 0.008 , 0.0044];						%Corrente inicial da corrente para Fonte 2 para os casos 1,2 e 3
tmax=uint32(t);
%--------------------------Calculo dos Vetores--------------------------%

%inicializa todos os vetores como zero
V = zeros(tmax,Valormax);		%Vetor com V(n+1) valores calculados de tensão para os dz no instante t para f1 Rl=\infty
I = zeros(tmax,Valormax);		%Vetor com I(n+1) valores calculados de corrente para os dz no instante t para f1 Rl=\infty

%-------------------------------------- Vetores  auxiliares ----------------------------------------%
%	Esses vetores auxiliares funcionam da seguinte forma:											%
%	 - auxiliares de tensão são os valores de V atrasados em n	 									%
%	 - auxiliares de corrente são para valores em para tempo no instante n-1/2						%
%---------------------------------------------------------------------------------------------------%
Vaux = zeros(1,Valormax);		
Iaux = zeros(1,Valormax);

		



button = menu('Qual Caso deseja visualizar o gráfico?','Fonte 1 para R = Infinito', 'Fonte 1 para R = 0', 'Fonte 1 para R 100 Ohms', 'Fonte 2 para R = Infinito', 'Fonte 2 para R = 0', 'Fonte 2 para R 100 Ohms');


if button == 1

		V0 = Vf1;
		Iaux(1,1)=If1(1,1);
		titulo = strcat("Tensão e Corrente das fonte 1 e Rl = Infinito");
		legendaTensao = strcat("V(t) \rightarrow R_L = \infty");
		legendaCorrente = strcat("I(t) \rightarrow R_L = \infty");

elseif button == 2

		V0 = Vf1;
		Iaux(1,1)=If1(1,2);
		titulo = strcat("Tensão e Corrente das fonte 1 e Rl = 0");
		legendaTensao = strcat("V(t) \rightarrow R_L = 0");
		legendaCorrente = strcat("I(t) \rightarrow R_L = 0");

elseif button == 3

		V0 = Vf1;
		Iaux(1,1)=If1(1,3);
		titulo = strcat("Tensão e Corrente das fonte 1 e Rl = 100 Ohms");
		legendaTensao = strcat("V(t) \rightarrow R_L = 100 \Omega");
		legendaCorrente = strcat("I(t) \rightarrow R_L = 100 \Omega");
	

elseif button == 4
		
		V0 = Vf2;
		Iaux(1,1)=If2(1,1);
		titulo = strcat("Tensão e Corrente das fonte 2 e Rl = 100 Ohms");
		legendaTensao = strcat("V(t) \rightarrow R_L = 100 \Omega");
		legendaCorrente = strcat("I(t) \rightarrow R_L = 100 \Omega");
elseif button == 5

		V0 = Vf2;
		Iaux(1,1)=If1(1,2);
		titulo = strcat("Tensão e Corrente das fonte 2 e Rl = 100 Ohms");
		legendaTensao = strcat("V(t) \rightarrow R_L = 100 \Omega");
		legendaCorrente = strcat("I(t) \rightarrow R_L = 100 \Omega");
elseif button == 6
		
		V0 = Vf2;
		Iaux(1,1)=If1(1,3);
		titulo = strcat("Tensão e Corrente das fonte 2 e Rl = 100 Ohms");
		legendaTensao = strcat("V(t) \rightarrow R_L = 100 \Omega");
		legendaCorrente = strcat("I(t) \rightarrow R_L = 100 \Omega");
end




h1 = figure('Name',titulo,'NumberTitle','off');	%Abre uma janela genérica para receber os gráficos

for y=1:tmax
	
	if (flag==1) && (button>=4) && (tdesliga<=(dt*y))
		V0			= 0;
		flag 		= 0;
	end

	V(y,1)=(1-c5)*Vaux(1,1)-2*Iaux(1,1)+2*Vf1;

	for k=2:Valormax-1		 %Loop de cálculo dos gráficos

		I(y,k)=c1*(Vaux(k)-Vaux(k-1))+c2*Iaux(k);
	end
	for k=2:Valormax-1		 %Loop de cálculo dos gráficos

		V(y,k)=c3*(I(y,k+1)-I(y,k))+c4*Vaux(k);
	end

	if(button==3) || (button==6)

	 	V(y,Valormax)=(1-c6)*Vaux(1,Valormax)+2*Iaux(1,Valormax-1);

	elseif (button==1) || (button==4)

		V(y,Valormax)=V(y,Valormax-1);
	elseif (button==2) || (button==5)

		V(y,Valormax)=0;
	end	
	%------------------ Passando os valores do Original para o auxiliar --------------------%
	%																						%
	%	Note: o vetor auxiliar sempre está um dt atrasado em relação ao seu Original 		%
	%																						%
	%---------------------------------------------------------------------------------------%
	Iaux=I(y,1:end);
	Vaux=V(y,1:end);
end

for n=1:tmax          %Loop de atualização dos gráficos
	figure(h1)
	s = strcat("Tempo: ",num2str(n*dt)," ps");
	disp(s);
	tiledlayout(2,1)
	nexttile
	plot(Z,V(n,:))
	xlabel('Z(m)')
	ylabel('U(V)') 
	grid on
	grid minor
	legend(legendaTensao)
	nexttile
	plot(Z,I(n,:))
	xlabel('Z (m)')
	ylabel('i(A)')
	grid on
	grid minor
	legend(legendaCorrente)
	getframe();
end


