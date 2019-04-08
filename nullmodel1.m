%%
% *NULLMODEL1.M* ------------------------ Código disponible en github.com/ferblasco7/Redes
%  ------------------------
%%
% *Null model 1: Crea matrices con el mismo tamaño y llenado (proporción de 1's de la original)*

%Heredamos las variables i e it del script en el que se llama al null model
m=size(matriz,1); n=size(matriz,2); nodfsNULL1=zeros(it,3);
    num_unos=sum(sum(matriz)); %numero de unos de matriz

    for j=1:it %creamos it nulls para cada matriz
        matrizNULL=zeros(m,n);
        %llenamos matrizNULL con tantos unos como tuviera matriz
        matrizNULL(randsample(1:m*n,num_unos))=1; 
        [nodfsNULL1(j,1),nodfsNULL1(j,2),nodfsNULL1(j,3)]=anida(matrizNULL,false);
    end
    
