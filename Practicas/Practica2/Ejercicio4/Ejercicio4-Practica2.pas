program Ejercicio4Practica2;
const
	valorAlto = 9999;
type
	date = record
		dia:integer;
		mes:integer;
		anio:integer;
		end;
	usuario = record
		cod:integer;
		fecha:date;
		tiempo:integer;
		end;
	arrRegD = array of sesion;
	arrD = array[1..5] of file of sesion;
	maestro = file of sesion;
procedure leerDetalle(var ad:detalle;var s:sesion);
begin
	if(not eof(ad))then
		read(ad,s);
	else
		s.cod := valorAlto;
end;
procedure minimo(var arrD:arrD;var arrRD:arrRegD;var min:sesion);
var
	minCod,i,pos:integer;
begin
	minCod := valorAlto;
	for(i:=1 to 5) do begin
		if(arrRD[i].cod < minCod)then begin
			pos:= i;
			minCod := arrRD[i].cod;
		end;
	end;
	min:= arrRD[pos];
	leerDetalle(arrD[pos],arrRD[pos]);
end;
var
	am: maestro;
	arrD: arrD;
	arrRD: arrRegD;
	i:integer;
	nue,min:sesion;
BEGIN
	assign(am,'maestro.txt');
	rewrite(am);
	for(i:=1 to 5) do begin
		assign(arrD[i],'detalle.txt')
		reset(arrD[i]);
		leerDetalle(arrD[i],arrRD[i]);
	end;
	minimo(arrD,arrRD,min);
	while(min.cod <> valorAlto)do begin
		nue.cod := min.cod;
		nue.fecha.dia := min.fecha.dia;
		nue.fecha.mes := min.fecha.mes;
		nue.fecha.anio := min.fecha.anio;
		while(min.cod = nue.cod)do begin
			while((nue.fecha.dia = min.fecha.dia) and (nue.fecha.mes = min.fecha.mes) and (nue.fecha.anio = min.fecha.anio))
				nue.sesion := nue.sesion + min.sesion;
				minimo(arrD,arrRD,min);
			end;
		end;
		write(am,nue);
	end;
END.
