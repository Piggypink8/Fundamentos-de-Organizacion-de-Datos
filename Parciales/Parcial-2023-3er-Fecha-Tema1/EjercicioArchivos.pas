program Parcial2023Fecha3Tema1;
const
	valorAlto = 9999;
type
	producto = record
		cod:integer;
		nombre:string;
		precio:real;
		stockAct:integer;
		stockMin:integer;
		end;
	
	prodDetalle = record
		cod:integer;
		cantVend:integer;
		end;
	
	maestro = file of producto;
	detalle = file of prodDetalle;
	
	arrDet = array[1..20] of detalle;
	arrRegDet = array[1..20] of prodDet;
procedure leerDetalle(var ad:detalle; var p:prodDet);
begin
	if(not eof(ad))then
		read(ad,p)
	else
		p.cod := valorAlto;
end;
procedure leerMaestro(var am:maestro; var p:producto);
begin
	if(not eof(am))then
		read(am,p)
	else
		p.cod := valorAlto;
end;
procedure minimo(var arrDet:arrDet; var arrRegDet:arrRegDet:var min:prodDet);
var
	p:prodDet;
	codMin,pos:integer;
begin
	codMin:= valorAlto;
	for(i:= 1 to 20)do begin
		if(arrRegDet[i].cod <= codMin)then begin
			codMin:= arrRegDet[i].cod;
			pos:= i;
		end;
	end;
	min := arrRegDet[pos];
	leerDetalle(arrDet[pos],arrRegDet[pos]);
end;
var
	arrDet:arrDet;
	arrRegDet:arrRegDet;
	am:maestro;
	min:prodDet;
	p:producto;
	monto: real;
	at:text;
	arrMontos:arrMontos;
	i,stockVend,montoTotalVend:integer;
BEGIN
	assign(at,'informeProductos.txt');
	rewrite(at);
	for(i:=1 to 20)do begin //Inicializo el arreglo de archivos detalles y el arreglo de registros
		assign(arrDet[i],'detalleDia',i,'.txt');
		reset(arrDet[i]);
		leerDetalle(arrDet[i],arrRegDet[i]);
	end;
	assign(am,'maestroProductos.txt');
	rewrite(am);
	//cargarMaestro(am); Cargo productos en el maestro
	minimo(arrDet,arrRegDet,min); // Obtengo el mínimo del arreglo de registros
	leerMaestro(am,p); // Recorro los detalles según el maestro
	while(p.cod <> valorAlto)do begin
		montoTotalVend := 0; // Monto total vendido del producto
		stockVend:= 0;
		while(p.cod = min.cod)do begin // Mientras el codigo mínimo sea igual al producto del maestro
			stockVend:= stockVend - min.cantVend; 
			monto := min.cantVend * p.precio;
			montoTotalVend:= montoTotalVend + monto;  
			minimo(arrDet,arrRegDet,min);
		end;
		p.stockAct:= p.stockAct - stockVend; // Descuento el stock vendido
		seek(am,filepos(am)-1);
		write(am,p); // Actualizo el maestro con el stock vendido
		if(montoTotalVend > 10000)then begin // Agrego al archivo de texto 
			writeln(at,p.cod);
			writeln(at,p.nombre);
		end;
		leerMaestro(am,p);
	end;
	close(at)
	close(am)
END.
