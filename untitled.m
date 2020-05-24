%------------------------------------------------------------------------%
%----------------- Trabalho 1 de Ondas SEL0312---------------------------%
%------------------------------------------------------------------------%
% ----------- Membros ------------- %
% Gabriela Barion Vidal ----------- %
% Rodrigo Bragato Piva ------------ %
% Pedro Ramos Cunha --------------- %
close all;

%-----------------------Constantes--------------------------------------%

c  = 299792458; %velocidade da luz em m/s

%---------------------- Definição de variáveis de controle -------------%

l=1;						%distância l definida pelo grupo de 1000mm (1m)
aux=500;					%número de divisões de dessa distancia que resultam no dz (1000/2000 -> dz=0.5)
Valormax =aux;
dz=l/aux;
Z = linspace(0,l,aux);			%distribuição uniforme dos pontos 'dz's ao longo da linha de transmissão
uf = (0.9*c);					%valor para atingir o ponto estacionário
maxt=dz/uf;						
dt = 0.9*maxt*10^(12);				%dt em nano segundo (ns)
t  = 10.^(12)*10*1/(uf);			%valor tmaximo de amostragem do FDTD	
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
V1 = zeros(1,Valormax);		%Vetor com V(n+1) valores calculados de tensão para os dz no instante t para f1 Rl=\infty
V2 = zeros(1,Valormax);		%Vetor com V(n+1) valores calculados de tensão para os dz no instante t para f1 Rl=0
V3 = zeros(1,Valormax);		%Vetor com V(n+1) valores calculados de tensão para os dz no instante t para f1 Rl=100
I1 = zeros(1,Valormax);		%Vetor com I(n+1/2) valores calculados de corrente para os dz no instante t para f1 Rl=\infty
I2 = zeros(1,Valormax);		%Vetor com I(n+1/2) valores calculados de corrente para os dz no instante t para f1 Rl=0
I3 = zeros(1,Valormax);		%Vetor com I(n+1/2) valores calculados de corrente para os dz no instante t para f1 Rl=100
V4 = zeros(1,Valormax);		%Vetor com V(n+1) valores calculados de tensão para os dz no instante t para f2 Rl=\infty
V5 = zeros(1,Valormax);		%Vetor com V(n+1) valores calculados de tensão para os dz no instante t para f2 Rl=0
V6 = zeros(1,Valormax);		%Vetor com V(n+1) valores calculados de tensão para os dz no instante t para f2 Rl=100
I4 = zeros(1,Valormax);		%Vetor com I(n+1/2) valores calculados de corrente para os dz no instante t para f1 Rl=\infty
I5 = zeros(1,Valormax);		%Vetor com I(n+1/2) valores calculados de corrente para os dz no instante t para f1 Rl=0
I6 = zeros(1,Valormax);		%Vetor com I(n+1/2) valores calculados de corrente para os dz no instante t para f1 Rl=100


%-------------------------------------- Vetores  auxiliares ----------------------------------------%
%	Esses vetores auxiliares funcionam da seguinte forma:											%
%	 - auxiliares de tensão são os valores de V atrasados em n	 									%
%	 - auxiliares de corrente são para valores em para tempo no instante n-1/2						%
%---------------------------------------------------------------------------------------------------%
V1aux = zeros(1,Valormax);		
V2aux = zeros(1,Valormax);		
V3aux = zeros(1,Valormax);		
I1aux = zeros(1,Valormax);		
I2aux = zeros(1,Valormax);		
I3aux = zeros(1,Valormax);		
V4aux = zeros(1,Valormax);		
V5aux = zeros(1,Valormax);		
V6aux = zeros(1,Valormax);		
I4aux = zeros(1,Valormax);		
I5aux = zeros(1,Valormax);		
I6aux = zeros(1,Valormax);		

		%Acrescenta as fontes e correntes iniciais no momento t=0
		V1(1) = Vf1;	 	 %Intruduz a fonte 1 para o caso 1
		I1(2) = If1(1);	 	 %Intruduz a corrente da fonte 2 para o caso 1
		I1aux(1) = If1(1);	 %Intruduz a corrente da fonte 2 para o caso 1


		V2(1) = Vf1;	 %Introduz a fonte 1 para o caso 2
		I2(1) = If1(2);	 %Introduz a corrente da fonte 2 para o caso 2	
		I2aux(1) = If1(2);	 %Introduz a corrente da fonte 2 para o caso 2


		V3(1) = Vf1;	 %Introduz a fonte 1 para o caso 3
		I3(1) = If1(3);	 %Introduz a corrente da fonte 2 para o caso 
		I2aux(1) = If1(2);	 %Introduz a corrente da fonte 2 para o caso 2
		



button = menu('Qual Caso deseja visualizar o gráfico?', 'Fonte 1 R_L \rightarrow \infty', 'Fonte 1 R_L \rightarrow 0', 'Fonte 1 R_L \rightarrow 100\Omega', 'Fonte 2 R_L \rightarrow \infty', 'Fonte 2 R_L \rightarrow 0','Fonte 2 R_L \rightarrow 100\Omega');


if button == 1
h1 = figure('Name','Tensão e Corrente das fontes 1 e 2','NumberTitle','off');	%Abre uma janela genérica para receber os gráficos
for n=0:dt:t          %Loop de atualização dos gráficos



	for k=2:Valormax-1		 %Loop de cálculo dos gráficos

		I1(k)=c1*(V1aux(k)-V1aux(k-1))+c2*I1aux(k);
	end
	for k=2:Valormax-1		 %Loop de cálculo dos gráficos

		V1(k)=c3*(I1(k+1)-I1(k))+c4*V1aux(k);
	end

	%------------------ Passando os valores do Original para o auxiliar --------------------%
	%																						%
	%	Note: o vetor auxiliar sempre está um dt atrasado em relação ao seu Original 		%
	%																						%
	%---------------------------------------------------------------------------------------%
	Iaux=I1(1,1:end);
	Vaux=V1(1,1:end);
	figure(h1)
	s = strcat("Tempo: ",num2str(n)," ps");
	disp(s);
	tiledlayout(2,1)
	nexttile
	plot(Z,V1)
	xlabel('Z(mm)')
	ylabel('U(V)') 
	grid on
	grid minor
	legend('V(t) \rightarrow R_L = \infty')
	nexttile
	plot(Z,I1)
	xlabel('dz(cm)')
	ylabel('i(A)')
	grid on
	grid minor
	legend('I(t) \rightarrow R_L = \infty')
	getframe();
end


elseif button == 2
	
h1 = figure('Name','Tensão e Corrente das fontes 1 e 2','NumberTitle','off');	%Abre uma janela genérica para receber os gráficos
for n=0:dt:t          %Loop de atualização dos gráficos

		%Acrescenta as fontes e correntes iniciais no momento t=0

	for k=2:Valormax-1		 %Loop de cálculo dos gráficos

		I2(k)=c1*(V2aux(k)-V2aux(k-1))+c2*I2aux(k);
	end
	for k=2:Valormax-1		 %Loop de cálculo dos gráficos

		V2(k)=c3*(I2(k+1)-I2(k))+c4*V2aux(k);
	end

	%------------------ Passando os valores do Original para o auxiliar --------------------%
	%																						%
	%	Note: o vetor auxiliar sempre está um dt atrasado em relação ao seu Original 		%
	%																						%
	%---------------------------------------------------------------------------------------%
	
	V2aux = V2(1,1:end);
	I2aux = I2(1,1:end);


	figure(h1)
	s = strcat("Tempo: ",num2str(n)," ps");
	disp(s);
	%set(handler.text1, 'string', ['Result: ' num2str(x)])
	tiledlayout(2,1)
	nexttile
	plot(Z,V2)
	xlabel('Z(mm)')
	ylabel('U(V)')  
	grid on
	grid minor
	legend('V(t) \rightarrow R_L = 0')
	nexttile
	plot(Z,I2)
	xlabel('dz(cm)')
	ylabel('i(A)')
	grid on
	grid minor
	legend('I(t) \rightarrow R_L = 0')
	getframe();
end
elseif button == 3
	h1 = figure('Name','Tensão e Corrente das fontes 1 e 2','NumberTitle','off');	%Abre uma janela genérica para receber os gráficos
for n=0:dt:t          %Loop de atualização dos gráficos

	for k=2:Valormax-1		 %Loop de cálculo dos gráficos

		I3(k)=c1*(V3aux(k)-V3aux(k-1))+c2*I3aux(k);
	end
	for k=2:Valormax-1		 %Loop de cálculo dos gráficos

		V3(k)=c3*(I3(k+1)-I3(k))+c4*V3aux(k);
	end


	%------------------ Passando os valores do Original para o auxiliar --------------------%
	%																						%
	%	Note: o vetor auxiliar sempre está um dt atrasado em relação ao seu Original 		%
	%																						%
	%---------------------------------------------------------------------------------------%

	V3aux = V3(1,1:end);
	I3aux = I3(1,1:end);



	figure(h1)
	s = strcat("Tempo: ",num2str(n)," ps");
	disp(s);
	%set(handler.text1, 'string', ['Result: ' num2str(x)])
	tiledlayout(2,1)
	nexttile
	plot(Z,V3)
	xlabel('dz(cm)')
	ylabel('V(t) (V)') 
	grid on
	grid minor
	legend('V(t) \rightarrow R_L = 100\Omega')
	nexttile
	plot(Z,I3)
	xlabel('dz(cm)')
	ylabel('i(A)')
	grid on
	grid minor
	legend('I(t) \rightarrow R_L = 100\Omega')
	getframe();
end
elseif button == 4
	disp('Europa');
elseif button == 5
	disp('Africa');
else
end