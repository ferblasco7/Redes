%%
% *NULLMODEL2.M* ------------------------ Código disponible en github.com/ferblasco7/Redes
%  ------------------------
%%
% *Null model 2 : La probabilidad de que Aij sea 1 es igual a la media entre la probabilidad de que un elemento de la fila i sea uno y la de que un elemento de la fila j sea uno*

%Heredamos la variable it del script en el que se llama al null model
m=size(matriz,1); n=size(matriz,2);nodfsNULL2=zeros(it,3);
   
prop_cols=sum(matriz,1)/m; %proporcion de unos en cada columna
prop_rows=sum(matriz,2)/n; %proporcion de unos en cada fila
[COL,ROW]=meshgrid(prop_cols,prop_rows); %repetimos los valores por filas y columnas para obtener:
%COL: probabilidad de ocupacion de cada elemento de la matriz por columna
%ROW: probabilidad de ocupacion de cada elemento de la matriz por fila
prob1=(COL+ROW)/2; %probabilidad de que haya un uno para cada elemento de la matriz

for j=1:it %creamos it nulls para cada matriz
matrizNULL=prob1>rand(m,n); %transformamos esa probabilidad en una ocupación de 0's y 1's mediante
 %generacion de numeros aleatorios y comparaciones

[nodfsNULL2(j,1),nodfsNULL2(j,2),nodfsNULL2(j,3)] =anida(matrizNULL,false);

end

   


