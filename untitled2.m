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

c  = 299792458; %velocidade da luz em m/s

%---------------------- Definição de variáveis de controle -------------%

l=1;								%distância l definida pelo grupo de 1000mm (1m)
aux=500;							%número de divisões de dessa distancia que resultam no dz (1000/2000 -> dz=0.5)
Valormax =aux;
dz=l/aux;
Z = linspace(0,l,aux);				%distribuição uniforme dos pontos 'dz's ao longo da linha de transmissão
uf = (0.9*c);						%valor para atingir o ponto estacionário
maxt=dz/uf;						
dt = 0.9*maxt*10^(12);				%dt em nano segundo (ns)
t  = 10.^(12)*10*l/(uf);			%valor tmaximo de amostragem do FDTD
tdesliga = 10.^(-12)*l/(10*uf);	
%-----------------------Constantes calculadas---------------------------%
c1 = -dt*10.^(-12)/(1.85*10.^(-7)*dz);				%Equação de Cálculo da Constante
c2 = 1;											%Valor da Constante Calculado
c3 = -dt*10.^(-12)/(7.41*10.^(-11)*dz);				%Equação de Cálculo da Constante
c4 = 1;											%Valor da constante Calculado
Vf1= 2;											%Valor inicial da Fonte 1
Vf2= 1; 										%Valor Inicial da Fonte 2
If1= [0 , 0.016 , 0.0089];						%Corrente inicial da corrente para Fonte 1 para os casos 1,2 e 3
If2= [0 , 0.008 , 0.0044];						%Corrente inicial da corrente para Fonte 2 para os casos 1,2 e 3

%--------------------------Calculo dos Vetores--------------------------%

%inicializa todos os vetores como zero
V = zeros(1,Valormax);		%Vetor com V(n+1) valores calculados de tensão para os dz no instante t para f1 Rl=\infty
I = zeros(1,Valormax);		%Vetor com I(n+1) valores calculados de corrente para os dz no instante t para f1 Rl=\infty

%-------------------------------------- Vetores  auxiliares ----------------------------------------%
%	Esses vetores auxiliares funcionam da seguinte forma:											%
%	 - auxiliares de tensão são os valores de V atrasados em n	 									%
%	 - auxiliares de corrente são para valores em para tempo no instante n-1/2						%
%---------------------------------------------------------------------------------------------------%
Vaux = zeros(1,Valormax);		
Iaux = zeros(1,Valormax);

		



button = menu('Qual Caso deseja visualizar o gráfico?','Fonte 1 para R = Infinito', 'Fonte 1 para R = 0', 'Fonte 1 para R 100 Ohms', 'Fonte 2 para R = Infinito', 'Fonte 2 para R = 0', 'Fonte 2 para R 100 Ohms');


if button == 1

		%Acrescenta as fontes e correntes iniciais no momento t=0
		V(1) = Vf1;	 	 	%Intruduz a fonte 1 para o caso 1
		I(1) = If1(1);	 	 %Intruduz a corrente da fonte 2 para o caso 1
		Iaux(1) = If1(1);	 %Intruduz a corrente da fonte 2 para o caso 1	
		titulo = strcat("Tensão e Corrente das fonte 1 e Rl = Infinito");
		legendaTensao = strcat("V(t) \rightarrow R_L = \infty");
		legendaCorrente = strcat("I(t) \rightarrow R_L = \infty");




elseif button == 2


		V(1) = Vf1;	 		 %Introduz a fonte 1 para o caso 2
		I(1) = If1(2);	 	 %Introduz a corrente da fonte 2 para o caso 2	
		Iaux(1) = If1(2);	 %Introduz a corrente da fonte 2 para o caso 2
		titulo = strcat("Tensão e Corrente das fonte 1 e Rl = 0");
		legendaTensao = strcat("V(t) \rightarrow R_L = 0");
		legendaCorrente = strcat("I(t) \rightarrow R_L = 0");



elseif button == 3
		V(1) = Vf1;			 %Introduz a fonte 1 para o caso 3
		I(1) = If1(3);		 %Introduz a corrente da fonte 2 para o caso 
		Iaux(1) = If1(3);	 %Introduz a corrente da fonte 2 para o caso 2
		titulo = strcat("Tensão e Corrente das fonte 1 e Rl = 100 Ohms");
		legendaTensao = strcat("V(t) \rightarrow R_L = 100 \Omega");
		legendaCorrente = strcat("I(t) \rightarrow R_L = 100 \Omega");
	

elseif button == 4
		V(1) = Vf2;			 %Introduz a fonte 1 para o caso 3
		I(1) = If2(1);		 %Introduz a corrente da fonte 2 para o caso 
		Iaux(1) = If1(1);	 %Introduz a corrente da fonte 2 para o caso 2
		titulo = strcat("Tensão e Corrente das fonte 2 e Rl = 100 Ohms");
		legendaTensao = strcat("V(t) \rightarrow R_L = 100 \Omega");
		legendaCorrente = strcat("I(t) \rightarrow R_L = 100 \Omega");
elseif button == 5
		V(1) = Vf2;			 %Introduz a fonte 1 para o caso 3
		I(1) = If2(2);		 %Introduz a corrente da fonte 2 para o caso 
		Iaux(1) = If1(2);	 %Introduz a corrente da fonte 2 para o caso 2
		titulo = strcat("Tensão e Corrente das fonte 2 e Rl = 100 Ohms");
		legendaTensao = strcat("V(t) \rightarrow R_L = 100 \Omega");
		legendaCorrente = strcat("I(t) \rightarrow R_L = 100 \Omega");
else
		V(1) = Vf2;			 %Introduz a fonte 1 para o caso 3
		I(1) = If2(3);		 %Introduz a corrente da fonte 2 para o caso 
		Iaux(1) = If2(3);	 %Introduz a corrente da fonte 2 para o caso 2
		titulo = strcat("Tensão e Corrente das fonte 2 e Rl = 100 Ohms");
		legendaTensao = strcat("V(t) \rightarrow R_L = 100 \Omega");
		legendaCorrente = strcat("I(t) \rightarrow R_L = 100 \Omega");
end




h1 = figure('Name',titulo,'NumberTitle','off');	%Abre uma janela genérica para receber os gráficos
for n=0:dt:t          %Loop de atualização dos gráficos

	if (flag==1) && (t>=tdesliga) && (button>=4)
		V(1)	= 0;
		I(1)	= 0;
		Iaux(1)	= 0;
		flag 	= 0;
	end

	for k=2:Valormax-1		 %Loop de cálculo dos gráficos

		I(k)=c1*(Vaux(k)-Vaux(k-1))+c2*Iaux(k);
	end
	for k=2:Valormax-1		 %Loop de cálculo dos gráficos

		V(k)=c3*(I(k+1)-I(k))+c4*Vaux(k);
	end

	%------------------ Passando os valores do Original para o auxiliar --------------------%
	%																						%
	%	Note: o vetor auxiliar sempre está um dt atrasado em relação ao seu Original 		%
	%																						%
	%---------------------------------------------------------------------------------------%
	Iaux=I(1,1:end);
	Vaux=V(1,1:end);
	figure(h1)
	s = strcat("Tempo: ",num2str(n)," ps");
	disp(s);
	tiledlayout(2,1)
	nexttile
	plot(Z,V)
	xlabel('Z(m)')
	ylabel('U(V)') 
	grid on
	grid minor
	legend(legendaTensao)
	nexttile
	plot(Z,I)
	xlabel('Z (m)')
	ylabel('i(A)')
	grid on
	grid minor
	legend(legendaCorrente)
	getframe();
end



