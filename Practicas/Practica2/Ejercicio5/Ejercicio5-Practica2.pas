program Ejercicio5Practica2;
const
	valorAlto = 9999;
type
		
	producto = record
		nombre:string;
		desc:string;
		stockDisp:integer;
		stockMin:integer;
		precio:real;
		end;
	prodD = record
		cantVendida:integer;
		cod:integer;
		end;
		
		
	arrRegD = array of prodD;
	detalle = file of prodD;
	arrD = array[1..30] of detalle;
	maestro = file of sesion;
procedure leerDetalle(var ad:detalle; var p:prodD);
begin
	if(not eof(ad))then
		read(ad,p)
	else
		p.cod:= valorAlto;
end;
procedure minimo(var arrD:arrD;var arrRD:arrRegD; var min:prodD);
var
	i,pos,minCod:integer;
begin
	minCod := valorAlto;
	for(i:=1 to 30)do begin
		if(arrRD[i].cod < minCod)then begin
			pos := i;
			minCod:= arrRD[i].cod
		end
	end;
	min:= arrRD[pos];
	leerDetalle(arrD[pos],arrRD[pos]);
end;
procedure leerMaestro(var am:maestro; var p:producto);
begin
	if(not eof(am))then
		read(am,p)
	else
		p.cod:= valorAlto;
end;
var
	am: maestro;
	arrD: arrD;
	arrRD: arrRegD;
	i:integer;
	min: prodD;
	regM:producto;
	at:text;
BEGIN
	assign(at,'listado.txt');
	rewrite(at);
	assign(am,'maestro.txt');
	reset(am);
	for(i:=1 to 30) do begin
		assign(arrD[i],'ad' + i);
		reset(arrD[i]);
		leerDetalle(arrD[i],arrRD[i]);
	end;
	minimo(arrD,arrRD,min);
	leerMaestro(am,regM);
	while(regM.cod <> valorAlto)do begin
		while(regM.cod = min.cod)do begin
			regM.stockDisp := regM.stockDisp - min.cantVendida;
			minimo(arrD,arrRD,min);
		end;
		seek(am,filepos(am) - 1);
		write(am,regM);
		writeln(at,regM.cod, ' ', regM.stockDisp, ' ', regM.stockMin);
		writeln(at,regM.nombre, ' ',regM.desc);
		if(regM.stockDisp > regM.stockMin) then
			writeln(at,regM.precio);
		leerMaestro(am,regM);
	end;
	close(am);
	close(at);
END.
