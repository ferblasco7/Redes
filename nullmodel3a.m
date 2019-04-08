%%
% *NULLMODEL3A.M* ------------------------ Código disponible en github.com/ferblasco7/Redes
%  ------------------------
%%
% *Null model 3a : Cada FILA de el mismo tamaño y llenado (proporción de 1's de la original)*

%Heredamos las variables i e it del script en el que se llama al null model
m=size(matriz,1); n=size(matriz,2);nodfsNULL3a=zeros(it,3);
    num_unos=sum(matriz,2); %numero de unos en cada fila
    
    for j=1:it %creamos it nulls para cada matriz
        matrizNULL=zeros(m,n);
        for k=1:m
        fila=matrizNULL(k,:); %fila k, que vamos a llenar de unos
        %num_unos(k) es el numero de unos en la fila k
        %llenamos la fila k con tantos unos como la fila k original
        fila(randsample(1:n,num_unos(k)))=1; 
        matrizNULL(k,:)=fila;
        end
        [nodfsNULL3a(j,1),nodfsNULL3a(j,2),nodfsNULL3a(j,3)]=anida(matrizNULL,false);
    end
    
