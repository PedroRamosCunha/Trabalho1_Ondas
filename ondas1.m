%------------------------------------------------------------------------%
%----------------- Trabalho 1 de Ondas SEL0312---------------------------%
%------------------------------------------------------------------------%
% ----------- Membros ------------- %
% Gabriela Barion Vidal ----------- %
% Rodrigo Bragato Piva ------------ %
% Pedro Ramos Cunha --------------- %
clear all;
close all;



%-----------------------Constantes--------------------------------------%

c  = 299792458; %velocidade da luz em m/s


%---------------------- Definição de variáveis de controle -------------%

l=1000;						%distância l definida pelo grupo de 1000mm (1m)
dz=2000;					%número de divisões de dessa distancia que resultam no dz (1000/2000 -> dz=0.5)
Z = linspace(l,0,dz);		%distribuição uniforme dos pontos 'dz's ao longo da linha de transmissão
uf = 1/(0.9*c);				%valor para atingir o ponto estacionário
dt = 100;					%dt em nano segundo (ns)
t  = 1.5*uf*10.^(12);		%valor tmaximo de amostragem do FDTD	

%-----------------------Constantes calculadas---------------------------%
c1 = dt*10.^(-12)/(1.85*10.^(-6)*0.0005);		%Equação de Cálculo da Constante
c2 = 1;											%Valor da Constante Calculado
c3 = dt*10.^(-12)/(7.4*10.^(-10)*0.0005);		%Equação de Cálculo da Constante
c4 = 1;											%Valor da constante Calculado
Vf1= 2;											%Valor inicial da Fonte 1
Vf2= 1; 										%Valor Inicial da Fonte 2
If1= [0 , 0.016 , 0.0089];						%Corrente inicial da corrente para Fonte 1 para os casos 1,2 e 3
If2= [0 , 0.008 , 0.0044];						%Corrente inicial da corrente para Fonte 2 para os casos 1,2 e 3

%--------------------------Calculo dos Vetores--------------------------%

%inicializa todos os vetores como zero
V1 = zeros(1,2000);		%Vetor com V(n+1) valores calculados de tensão para os dz no instante t para f1 Rl=\infty
V2 = zeros(1,2000);		%Vetor com V(n+1) valores calculados de tensão para os dz no instante t para f1 Rl=0
V3 = zeros(1,2000);		%Vetor com V(n+1) valores calculados de tensão para os dz no instante t para f1 Rl=100
I1 = zeros(1,2000);		%Vetor com I(n+1/2) valores calculados de corrente para os dz no instante t para f1 Rl=\infty
I2 = zeros(1,2000);		%Vetor com I(n+1/2) valores calculados de corrente para os dz no instante t para f1 Rl=0
I3 = zeros(1,2000);		%Vetor com I(n+1/2) valores calculados de corrente para os dz no instante t para f1 Rl=100
V4 = zeros(1,2000);		%Vetor com V(n+1) valores calculados de tensão para os dz no instante t para f2 Rl=\infty
V5 = zeros(1,2000);		%Vetor com V(n+1) valores calculados de tensão para os dz no instante t para f2 Rl=0
V6 = zeros(1,2000);		%Vetor com V(n+1) valores calculados de tensão para os dz no instante t para f2 Rl=100
I4 = zeros(1,2000);		%Vetor com I(n+1/2) valores calculados de corrente para os dz no instante t para f1 Rl=\infty
I5 = zeros(1,2000);		%Vetor com I(n+1/2) valores calculados de corrente para os dz no instante t para f1 Rl=0
I6 = zeros(1,2000);		%Vetor com I(n+1/2) valores calculados de corrente para os dz no instante t para f1 Rl=100


%-------------------------------------- Vetores  auxiliares ----------------------------------------%
%	Esses vetores auxiliares funcionam da seguinte forma:											%
%	 - auxiliares de tensão são os valores de V atrasados em n	 									%
%	 - auxiliares de corrente são para valores em para tempo no instante n-1/2						%
%---------------------------------------------------------------------------------------------------%
V1aux = zeros(1,2000);		
V2aux = zeros(1,2000);		
V3aux = zeros(1,2000);		
I1aux = zeros(1,2000);		
I2aux = zeros(1,2000);		
I3aux = zeros(1,2000);		
V4aux = zeros(1,2000);		
V5aux = zeros(1,2000);		
V6aux = zeros(1,2000);		
I4aux = zeros(1,2000);		
I5aux = zeros(1,2000);		
I6aux = zeros(1,2000);		



h1 = figure('Name','Tensão e Corrente das fontes 1 e 2','NumberTitle','off');	%Abre uma janela genérica para receber os gráficos
for n=0:t          %Loop de atualização dos gráficos

		%Acrescenta as fontes e correntes iniciais no momento t=0
		V1(1) = Vf1;	 %Intruduz a fonte 1 para o caso 1
		V2(1) = Vf1;	 %Introduz a fonte 1 para o caso 2
		V3(1) = Vf1;	 %Introduz a fonte 1 para o caso 3

		V4(1) = Vf2;	 %Intruduz a fonte 2 para o caso 1
		V5(1) = Vf2;	 %Introduz a fonte 2 para o caso 2
		V6(1) = Vf2;	 %Introduz a fonte 2 para o caso 3

		I1(1) = If1(1);	 %Intruduz a corrente da fonte 2 para o caso 1
		I2(1) = If1(2);	 %Introduz a corrente da fonte 2 para o caso 2
		I3(1) = If1(3);	 %Introduz a corrente da fonte 2 para o caso 3

		I4(1) = If2(1);	 %Intruduz a corrente da fonte 2 para o caso 1
		I5(1) = If2(2);	 %Introduz a corrente da fonte 2 para o caso 2
		I6(1) = If2(3);	 %Introduz a corrente da fonte 2 para o caso 3


		V1aux(1) = Vf1;	 %Intruduz a fonte 1 para o caso 1
		V2aux(1) = Vf1;	 %Introduz a fonte 1 para o caso 2
		V3aux(1) = Vf1;	 %Introduz a fonte 1 para o caso 3

		V4aux(1) = Vf2;	 %Intruduz a fonte 2 para o caso 1
		V5aux(1) = Vf2;	 %Introduz a fonte 2 para o caso 2
		V6aux(1) = Vf2;	 %Introduz a fonte 2 para o caso 3

		I1aux(1) = If1(1);	 %Intruduz a corrente da fonte 2 para o caso 1
		I2aux(1) = If1(2);	 %Introduz a corrente da fonte 2 para o caso 2
		I3aux(1) = If1(3);	 %Introduz a corrente da fonte 2 para o caso 3

		I4aux(1) = If2(1);	 %Intruduz a corrente da fonte 2 para o caso 1
		I5aux(1) = If2(2);	 %Introduz a corrente da fonte 2 para o caso 2
		I6aux(1) = If2(3);	 %Introduz a corrente da fonte 2 para o caso 3


	for k=2:l-2		  %Loop de cálculo dos gráficos

		I1(k)=c1*(V1aux(k+1)-V1aux(k-1))+c2*I1aux(k);
		V1(k+1)=c3*(I1(k+2)-I1(k))+c4*V1aux(k+1);

		I1(k)=c1*(V1aux(k+1)-V1aux(k-1))+c2*I1aux(k);
		V1(k+1)=c3*(I1(k+2)-I1(k))+c4*V1aux(k+1);

		I1(k)=c1*(V1aux(k+1)-V1aux(k-1))+c2*I1aux(k);
		V1(k+1)=c3*(I1(k+2)-I1(k))+c4*V1aux(k+1);

		I1(k)=c1*(V1aux(k+1)-V1aux(k-1))+c2*I1aux(k);
		V1(k+1)=c3*(I1(k+2)-I1(k))+c4*V1aux(k+1);

		I1(k)=c1*(V1aux(k+1)-V1aux(k-1))+c2*I1aux(k);
		V1(k+1)=c3*(I1(k+2)-I1(k))+c4*V1aux(k+1);

		I1(k)=c1*(V1aux(k+1)-V1aux(k-1))+c2*I1aux(k);
		V1(k+1)=c3*(I1(k+2)-I1(k))+c4*V1aux(k+1);
	end

	%------------------ Passando os valores do Original para o auxiliar --------------------%
	%																						%
	%	Note: o vetor auxiliar sempre está um dt atrasado em relação ao seu Original 		%
	%																						%
	%---------------------------------------------------------------------------------------%
	V1aux = V1(1,:);
	V2aux = V2(1,:);
	V3aux = V3(1,:);
	V4aux = V4(1,:);
	V5aux = V5(1,:);
	V6aux = V6(1,:);

	I1aux = I1(1,:);
	I2aux = I2(1,:);
	I3aux = I3(1,:);
	I4aux = I4(1,:);
	I5aux = I5(1,:);
	I6aux = I5(1,:);


	figure(h1)
	s = strcat("Tempo: ",num2str(n)," ns");
	%uicontrol('Style','text','String',s);
	disp(s);
	%set(handler.text1, 'string', ['Result: ' num2str(x)])
	%tiledlayout(2,2)
	%nexttil
	plot(Z,V1,Z,V2,Z,V3)
	xlabel('dz(cm)')
	ylabel('dv(v)') 
	grid on
	grid minor
	%nexttile
	%plot(Z,I1,Z,I2,Z,I3)
	%xlabel('dz(cm)')
	%ylabel('i(A)')
	%grid on
	%grid minor
	%legend('I(t) \rightarrow R_L = \infty','I(t) \rightarrow R_L = 0','I(t) \rightarrow R_L = 100\Omega')
	%nexttile
	%plot(Z,V4,Z,V5,Z,V6)
	%xlabel('dz(cm)')
	%ylabel('dv(v)') 
	%grid on
	%grid minor
	%legend('V(t) \rightarrow R_L = \infty','V(t) \rightarrow R_L = 0','V(t) \rightarrow R_L = 100\Omega')
	%nexttile
	%plot(Z,I4,Z,I5,Z,I6)
	%xlabel('dz(cm)')
	%ylabel('i(A)')
	%grid on
	%grid minor
	%legend('I(t) \rightarrow R_L = \infty','I(t) \rightarrow R_L = 0','I(t) \rightarrow R_L = 100\Omega')
	getframe();
end