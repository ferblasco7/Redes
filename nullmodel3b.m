%%
% *NULLMODEL3B.M* ------------------------ Código disponible en github.com/ferblasco7/Redes
%  ------------------------
%%
% *Null model 3b : Cada COLUMNA de el mismo tamaño y llenado (proporción de 1's de la original)*

%Heredamos las variables i e it del script en el que se llama al null model
m=size(matriz,1); n=size(matriz,2); nodfsNULL3b=zeros(it,3);
    num_unos=sum(matriz,1); %numero de unos en cada columna

    for j=1:it %creamos it nulls para cada matriz
            matrizNULL=zeros(m,n);
        for k=1:n
        col=matrizNULL(:,k); %columna k, que vamos a llenar de unos
        %num_unos(k) es el numero de unos en la columna k
        %llenamos la col. k con tantos unos como la col. k original
        col(randsample(1:m,num_unos(k)))=1; 
        matrizNULL(:,k)=col;
        end
        [nodfsNULL3b(j,1),nodfsNULL3b(j,2),nodfsNULL3b(j,3)]=anida(matrizNULL,false);
    end
    
