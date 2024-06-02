program Ejercicio1Practica2;
const
	valorAlto = 9999;
type
	producto = record
		cod:integer;
		nombre:String[20];
		desc:String[20];
		stockDisp:integer;
		stockMin:integer;
		precio:real;
		end;
		
	prod_det = record
		cod:integer;
		cantVend:integer;
		end;
		
	maestro = file of producto
	arreglo_detalle = array [1..30] of file of detalle;
	arreglo_producto = array [1..30] of prod_det;
	
procedure leerDetalle(var ad:detalle;var p:prod_det);
begin
	if(not eof(ad))then
		read(a,p);
	else
		p.cod := valorAlto
end;

procedure minimo(var arrd:arreglo_detalle;var arrp:arreglo_producto;var min:prod_det);
var
	pos,minCod,i:integer;
begin
	minCod:= valorAlto;
	// Agrego el primer producto de cada detalle en el arreglo de productos
	for (i:=1 to 30) do begin
		if(arrp[i].cod < minCod)then begin
			min:= arrp[i];
			minCod:= min.cod;
			pos:= i;
		end;
	end;
	leerDetalle(arrd[pos],arrp[pos]);
end;

procedure listarProductos(var am:maestro;var at:text);
var
	p:producto;
begin
	rewrite(at);
	reset(am);
	while(not eof(am))do begin
		read(am,p);
		writeln(at,p.nombre,' ',p.desc);
		writeln(at,p.stockVend)
		if(p.stockVend < p.stockMin)then
			writeln(at, p.precio);
	end;
	close(am);
	close(at);
end;
var
	am: maestro;
	arrd: arreglo_detalle;
	arrp: arreglo_producto;
	cod:integer;
	total:integer;
	p:producto;
	at: text;
BEGIN
	assign(at,'listadoProductos.txt');
	assign(am,'maestro.txt');
	rewrite(am);
	for i:=1 to 30 do begin
		//assign
		reset(arrd[i]);
		leerDetalle(arrd[i],arrp[i]);
	end;
	
	minimo(arrd,arrp,min);
	while(min.cod <> valorAlto) do begin
		read(am,p);
		total:= 0;
		cod:= min.cod;
		while(cod = min.cod) do begin
			total:= total + min.cantVend;
			minimo(arrd,arrp,min);
		end;
		a.stockDisp:= a.stockDisp - total;
		seek(am,filepos(am)-1);
		write(am,a);
	end;
	listarProductos(am,at);
END.
