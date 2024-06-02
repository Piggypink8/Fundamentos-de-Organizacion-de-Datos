program 
const
	valorAlto = 9999;
type

	infoD = record
		codLocal:integer;
		cepa:integer;
		activos:integer;
		nuevos:integer;
		recup:integer;
		fallec:integer;
		end;
		
	infoM = record; 
		codLocal:integer;
		nomLoc:string;
		cepa:integer;
		nomCepa:string;
		activos:integer;
		nuevos:integer;
		recup:integer;
		fallec:integer;
		end;
		
	detalle = file of infoD;
	arrRegD = array[1..10] of infoD;
	arrD = array[1..10] of detalle;
	maestro = file of infoM;
procedure leerDetalle(var ad:detalle;var i:infoD);
begin
	if(not eof(ad))then
		read(ad,i)
	else
		i.cod := valorAlto;
end;
procedure minimo(var arrD:arrD;var arrRD:arrRegD; var min:infoD);
var
	i,pos,minCod:integer;
begin
	minCod := valorAlto;
	for(i:=1 to 10)do begin
		if(arrRD[i].cod < minCod)then begin
			pos := i;
			minCod := arrRD[pos].cod;
		end
	end;
	min := arrRD[pos];
	leerDetalle(arrD[pos],arrRD[pos]);
end;
procedure leerMaestro(var am:maestro;var i:infoM);
begin
	if(not eof(am))then
		read(am,i);
	else
		i.cod := valorAlto;
end;
var
	cantActivosTotal,cant:integer;
	arrD:arrD;
	arrRD:arrRegD;
	am:maestro;
	min:infoD;
	regM: infoM;
BEGIN
	assign(am,'maestro.txt');
	rewrite(am);
	for(i:=1 to 5) do begin
		assign(arrD[i],'detalle.txt')
		reset(arrD[i]);
		leerDetalle(arrD[i],arrRD[i]);
	end;
	cantActivosTotal := 0;
	minimo(arrD,arrRD,min);
	leerMaestro(am,regM);
	while(min.cod <> valorAlto)do begin
		cant:= 0;
		while(regM.cod = min.cod)do begin
			while(regM.codLocal = min.codLocal)do begin
				regM.fallec := regM.fallec + min.fallec;
				regM.recup := regM.recup + min.recup;
				regM.activos := min.activos;
				regM.nuevos := min.nuevos;
				cant := cant + min.activos;
				minimo(arrD,arrRD,min);
			end;
			if(cant > 50)then
				cantActivosTotal := cantActivosTotal + 1;
			seek(am,filepos(am) - 1);
			write(am,regM);
		end;
	end;
	writeln('localidades com mas de 50 activos: ', cantActivosTotal);
	close(am);
END.

// (las localidades pueden o no haber sido actualizadas <<- explicar
