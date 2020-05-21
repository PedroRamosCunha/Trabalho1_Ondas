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
Z = linspace(l,0,l)			%distribuição uniforme dos pontos 'dz's ao longo da linha de transmissão
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
If1= [0 , 0.016 , 0.0089]						%Corrente inicial da corrente para Fonte 1 para os casos 1,2 e 3
If2= [0 , 0.008 , 0.0044]						%Corrente inicial da corrente para Fonte 2 para os casos 1,2 e 3

%--------------------------Calculo dos Vetores--------------------------%

%inicializa todos os vetores como zero
V1 = zeros(1,1000);		%Vetor com V valores calculados de tensão para os dz no instante t para f1 Rl=\infty
V2 = zeros(1,1000);		%Vetor com V valores calculados de tensão para os dz no instante t para f1 Rl=0
V3 = zeros(1,1000);		%Vetor com V valores calculados de tensão para os dz no instante t para f1 Rl=100
I1 = zeros(1,1000);		%Vetor com I valores calculados de corrente para os dz no instante t para f1 Rl=\infty
I2 = zeros(1,1000);		%Vetor com I valores calculados de corrente para os dz no instante t para f1 Rl=0
I3 = zeros(1,1000);		%Vetor com I valores calculados de corrente para os dz no instante t para f1 Rl=100
V4 = zeros(1,1000);		%Vetor com V valores calculados de tensão para os dz no instante t para f2 Rl=\infty
V5 = zeros(1,1000);		%Vetor com V valores calculados de tensão para os dz no instante t para f2 Rl=0
V6 = zeros(1,1000);		%Vetor com V valores calculados de tensão para os dz no instante t para f2 Rl=100
I4 = zeros(1,1000);		%Vetor com I valores calculados de corrente para os dz no instante t para f1 Rl=\infty
I5 = zeros(1,1000);		%Vetor com I valores calculados de corrente para os dz no instante t para f1 Rl=0
I6 = zeros(1,1000);		%Vetor com I valores calculados de corrente para os dz no instante t para f1 Rl=100




h1 = figure('Name','Tensão e Corrente das fontes 1 e 2','NumberTitle','off');	%Abre uma janela genérica para receber os gráficos
for n=-200:dt:t          %Loop de atualização dos gráficos

	if(t>=0)			 %Acrescenta as fontes e correntes iniciais no momento t=0
		V1(1) = Vf1;	 %Intruduz a fonte 1 para o caso 1
		V2(1) = Vf1;	 %Introduz a fonte 1 para o caso 2
		V3(1) = Vf1;	 %Introduz a fonte 1 para o caso 3

		V4(1) = Vf2;	 %Intruduz a fonte 2 para o caso 1
		V5(1) = Vf2;	 %Introduz a fonte 2 para o caso 2
		V6(1) = Vf2;	 %Introduz a fonte 2 para o caso 3

		V4(1) = Vf2;	 %Intruduz a corrente da fonte 2 para o caso 1
		V5(1) = Vf2;	 %Introduz a corrente da fonte 2 para o caso 2
		V6(1) = Vf2;	 %Introduz a fonte 2 para o caso 3

	for k=l-1:1		  %Loop de cálculo dos gráficos

		I1()=c1*(V1()-V1())*c2*I1();
		V1()=c3*(I1()-I1())+c4*V1();

		I2()=c1*(V2()-V2())*c2*I2();
		V2()=c3*(I2()-I2())+c4*V2();

		I3()=c1*(V3()-V3())*c2*I3();
		V3()=c3*(I3()-I3())+c4*V3();

		I4()=c1*(V4()-V4())*c2*I4();
		V4()=c3*(I4()-I4())+c4*V4();

		I5()=c1*(V5()-V5())*c2*I5();
		V5()=c3*(I5()-I5())+c4*V5();

		I6()=c1*(V6()-V6())*c2*I6();
		V6()=c3*(I6()-I6())+c4*V6();
	end

	figure(h1)
	s = strcat("Tempo: ",num2str(n)," ns");
	uicontrol('Style','text','String',s);
	disp(s);
	%set(handler.text1, 'string', ['Result: ' num2str(x)])
	tiledlayout(2,2)
	nexttile
	plot(Z,V1,Z,V2,Z,V3)
	xlabel('dz(cm)')
	ylabel('dv(v)') 
	grid on
	grid minor
	nexttile
	plot(Z,I1,Z,I2,Z,I3)
	xlabel('dz(cm)')
	ylabel('i(A)')
	grid on
	grid minor
	legend('I(t) \rightarrow R_L = \infty','I(t) \rightarrow R_L = 0','I(t) \rightarrow R_L = 100\Omega')
	nexttile
	plot(Z,V4,Z,V5,Z,V6)
	xlabel('dz(cm)')
	ylabel('dv(v)') 
	grid on
	grid minor
	legend('V(t) \rightarrow R_L = \infty','V(t) \rightarrow R_L = 0','V(t) \rightarrow R_L = 100\Omega')
	nexttile
	plot(Z,I4,Z,I5,Z,I6)
	xlabel('dz(cm)')
	ylabel('i(A)')
	grid on
	grid minor
	legend('I(t) \rightarrow R_L = \infty','I(t) \rightarrow R_L = 0','I(t) \rightarrow R_L = 100\Omega')
	getframe();
end