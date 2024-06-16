program
const
	valorAlto = 9999;
type
	producto = record
		cod:integer;
		nombre;string[10];
		precio:real;
		stockAct:integer;
		stockMin:integer;
		end;
	prodVend = record
		cod:integer;
		cant:integer;
		end;
	maestro = file of producto;
	detalle = file of prodVend;
	arrRD = array[1..5] of prodVend;
	arrD = array[1..5] of detalle;
procedure leerDetalle(var ad:detalle;var p:prodVend);
begin
	if(not eof(ad))then
		read(ad,p)
	else
		p.cod:= valorAlto;
begin;
procedure leerMaestro(var am:maestro;var p:producto);
begin
	if(not eof(am))then
		read(am,p)
	else
		p.cod:= valorAlto;
begin;
procedure buscarProducto(var am:maestro;cod:integer;var pos:integer);
var
	regm:producto;
begin
	reset(am);
	leerMaestro(am,regm);
	while(regm.cod <> cod) do
		leerMaestro(am,regm); 
	pos:= filepos(am)-1;;
	{if(regd.cod = cod)then
		p := regd;
	else
		p:= valorAlto; --> caso si hay uno solo}
	close(ad);
end;
procedure actualizarMaestro(var am:maestro);
var
	cod,pos,total:integer;
	regm:producto;
	regd:prodVend;
begin
	reset(am);
	leerDetalle(ad,regd);
	while(regd.cod <> valorAlto)do begin
		total:=0;
		buscarProducto(am,regd.cod,pos);
		seek(am,pos);
		leerMaestro(am,regm);
		regm.stockAct := regm.stockAct - 1;
		seek(am,filepos(am)-1);
		write(am,regm);
		leerDetalle(ad,regd);
	end;
	close(am);
end;
var
BEGIN
END.
