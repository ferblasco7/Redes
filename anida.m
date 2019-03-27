%%
% *ANIDA.M* 
%%
% *Calcula el NODF y representa gráficamente la red compleja a partir de su matriz de biadyacencia*
function [NODF,NODFcols,NODFrows]=anida(matriz) %Input: Matriz de biadyacencia; Output: NODF medio, NODF de las columnas y NODF de las filas
%%
% *Ordenamos la matriz de mayor a menor total marginal (cantidad de unos) por filas y columnas*
[~,ordenrows]=sort(sum(matriz,2),'descend');
[~,ordencols]=sort(sum(matriz,1),'descend');

matriz(1:size(matriz,1),:)=matriz(ordenrows,:);
matriz(:,1:size(matriz,2))=matriz(:,ordencols);

%% 
% *Eliminamos las filas o columnas que sólo contengan ceros (no aportan info. y NODF no está diseñado para procesarlas)*
c=0; %contador de filas/columnas eliminadas
%Si hay filas/columnas de ceros, estarán ahora colocadas al final de la
%matriz, por lo que las buscamos allí:
while sum(matriz(size(matriz,1),:))==0
    matriz(size(matriz,1),:)=[];
    c=c+1;
end
while sum(matriz(:,size(matriz,2)))==0
    matriz(:,size(matriz,2))=[];
    c=c+1;
end
%Advertencia de que había filas con ceros:
if c~=0
    warning(['Se han eliminado ' num2str(c) ' filas/columnas sólo compuestas de 0'])
end
%% 
% *Representamos la matriz y el grafo. 
% (Es muy recomendable comentar esta zona cuando se requiera eficiencia al calcular NODF).*
figure(1)
imagesc(matriz) %Representacion de la matriz de datos: Los unos en blanco y los ceros en negro
colormap(gray)
set(gca,'xtick',[],'YTick',[]) %Evitamos la numeración de los ejes

figure(2)
ady=[zeros(size(matriz,1)),matriz;
    matriz',zeros(size(matriz,2))]; %creamos la matriz de adyacencia de un grafo bipartito (ady) a partir de la de biadyacencia (matriz)
grafo=graph(ady); %creamos el objeto graph asociado a dicha matriz de adyacencia
p=plot(grafo,'LineWidth',3,'MarkerSize',20); %representacion del grafo, con parámetros gráficos adecuados para grafos pequeños
axis off
nl = p.NodeLabel; %salvar etiquetas de nodos para incluirlas como texto
p.NodeLabel = ''; %eliminar las etiquetas de nodo originales para evitar su representación (muy pequeñas e ilegibles)
xd = get(p, 'XData'); %Tomamos las coordenadas de los nodos para escribir sus etiquetas en dichas coordenadas
yd = get(p, 'YData');
%Configuración de la aparición del texto
text(xd,yd,nl,'FontSize',18,'FontWeight','bold' , 'HorizontalAlignment','left','VerticalAlignment','middle','Color','white')


figure(3)
%Ahora representamos el grafo de manera que se vea su carácter bipartito
%(C1 a la derecha y C2 a la izquierda). Hay que hacerlo "a mano" porque
%Matlab no incorpora una opción especial para redes bipartitas.
xd=[repelem(1,size(matriz,1)),repelem(2,size(matriz,2))];
yd=[size(matriz,1):-1:1,size(matriz,2):-1:1];
%Parámetros gráficos concretos para la matriz de ejemplo, habría que
%variarlos para otros grafos
p=plot(grafo,'XData',xd,'YData',yd,'LineWidth',3,'MarkerSize',20);
nl = p.NodeLabel; 
p.NodeLabel = ''; %eliminar las etiquetas de nodo originales (muy pequeñas e ilegibles)
axis off
%Configuración de la aparición del texto
text(xd,yd,nl,'FontSize',18,'FontWeight','bold' , 'HorizontalAlignment','left', 'VerticalAlignment','middle','Color','white')
%% 
% *Calculamos el nestedness (NODF)*

%Hallamos DF/100, equivalente a DF y más eficiente por usar la estructura logical
c=1;DFrows=[];DFcols=[];
for i=1:size(matriz,1)
    for j=(i+1):size(matriz,1)
        DFrows(c)=sum(matriz(i,:))>sum(matriz(j,:)); %llenado en el orden de comparacion de indices de mayor a menor: 
        % i=1 con i=2,1-3,1-4,...,2-3,2-4,2-5,...
        c=c+1;
    end
end
c=1;
for i=1:size(matriz,2)
    for j=(i+1):size(matriz,2)
        DFcols(c)=sum(matriz(:,i))>sum(matriz(:,j));
        c=c+1;
    end
end

%Hallamos Npaired
c=1;NProws=[];NPcols=[];
for i=1:size(matriz,1) %npaired de las filas
    for j=(i+1):size(matriz,1)
        NProws(c)=DFrows(c)*sum(matriz(j,:) & matriz(i,:))/sum(matriz(j,:))*100; %Npaired=DF*PO
        c=c+1;
    end
end
c=1;
for i=1:size(matriz,2) %npaired de las columnas
    for j=(i+1):size(matriz,2)
        NPcols(c)=DFcols(c)*sum(matriz(:,j) & matriz(:,i))/sum(matriz(:,j))*100; %Npaired=DF*PO
        c=c+1;
    end
end

%Hallamos NODF a partir de Npaired medio

NODFcols=sum(NPcols)/length(NPcols);
NODFrows=sum(NProws)/length(NProws);
NODF=(NODFcols+NODFrows)/2;
end
