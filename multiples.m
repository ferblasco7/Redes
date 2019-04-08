%%
% *MULTIPLES.M* ------------------------ Código disponible en github.com/ferblasco7/Redes
%  ------------------------
%%
% *CALCULA LA PROBABILIDAD DE QUE EL NODF DE CADA MATRIZ SEA MAYOR QUE EN CADA MODELO NULO.*
% *Ejecutado para una sola matriz, (i=indice de la matriz deseada) devuelve todos los resultados de nodfs de modelos nulos, permitiendo calcular intervalos de confianza*

%%
% *Inicializamos variables*
clear nodfs;clear nodfm; clear nodfsNULL
it=200; %numero de null models a obtener para cada matriz
narchivos=95; %hay 95 archivos BIN en la WoL
nodfs=zeros(narchivos,3);nodfsg=zeros(1,narchivos);nodfscols=zeros(1,narchivos);nodfsrows=zeros(1,narchivos);%p=zeros(narchivos,4);

%%
% *Iteramos para todas las matrices deseadas*
for i=1:narchivos
    if i==17
        continue
    end
    nombre=[num2str(i),'.csv'];
    matriz=csvread(nombre);
    [nodfsg(i),nodfscols(i),nodfsrows(i)]=anida(matriz,false);
    nodfs(i,:)= [nodfsg(i)',nodfscols(i)',nodfsrows(i)'];
    %% 
    % *Null models para comparar*
    nullmodel1

    nullmodel2

    nullmodel3a
   
    nullmodel3b

    disp(i)
    var=3; %tipo de nodf a comprobar: 1 global, 2 por columnas y 3 por filas
        p(i,1)=mean(nodfsNULL1(:,var)<nodfs(i,var));
        p(i,2)=mean(nodfsNULL2(:,var)<nodfs(i,var));
        p(i,3)=mean(nodfsNULL3a(:,var)<nodfs(i,var));
        p(i,4)=mean(nodfsNULL3b(:,var)<nodfs(i,var));
end

%%
% *Datos nodfs*

nodfm=mean(nodfs);
nodfmCols=mean(nodfscols);
nodfmRows=mean(nodfsrows);
%nodfmNULL=sum(sum(nodfsNULL))/(size(nodfsNULL,1)*size(nodfsNULL,2));
pm=mean(p);



