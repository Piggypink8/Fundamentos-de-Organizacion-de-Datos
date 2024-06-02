program Ejercicio1Practica2;
type
	empleado = record
		cod:integer;
		nombre:String[11];
		monto:integer;
		end;
	maestro = file of empleado;
	detalle = file of empleado;
	archivoText = text;
	
procedure leerEmpleado(var e:empleado);
begin
	writeln('Ingrese codigo');
	readln(e.cod);
	if(e.cod <> 0)then begin
		writeln('Ingrese nombre');
		readln(e.nombre);
		writeln('Ingrese monto');
		readln(e.monto);
	end;
end;
procedure cargarArchivoDetalle(var ad:detalle);
var
	e:empleado;
begin
	reset(ad);
	leerEmpleado(e);
	while( e.cod <> 0 )do begin
		write(ad,e);
		leerEmpleado(e);
	end;
	close(ad);
end;
procedure leerDetalle(var ad:detalle;var e:empleado);
begin
	if(not eof(ad))then
		read(ad,e)
	else
		e.cod:= 9999;
	
end;
// esta bien usar el mismo registro o debo crear otro(regd y regm)?
procedure cargarArchivoMaestro(var am:maestro;var ad:detalle);
var
	e,nue:empleado; 
	total:integer;
begin
	reset(am);
	reset(ad);
	leerDetalle(ad,e);
	while(e.cod <> 9999)do begin
		nue := e;
		total:= 0;
		while(e.cod = nue.cod)do begin
			total:= total + e.monto;
			leerDetalle(ad,e);
		end;
		nue.monto := total;
		write(am,nue);
	end;
	close(ad);
	close(am);
end;
procedure cargarArchivoText(var at:archivoText;var ad:detalle);
var
	e,nue:empleado; 
	total:integer;
begin
	rewrite(at);
	reset(ad);
	leerDetalle(ad,e);
	while(e.cod <> 9999)do begin
		nue.cod := e.cod;
		nue.nombre:= e.nombre;
		total:= 0;
		while(e.cod = nue.cod)do begin
			total:= total + e.monto;
			leerDetalle(ad,e);
		end;
		nue.monto := total;
		writeln(at,nue.cod, ' ', nue.nombre, ' ', nue.monto);
	end;
	close(ad);
	close(at);
end;
var
	arch_maestro : maestro;
	arch_detalle : detalle;
	arch_text : archivoText;
BEGIN
	assign(arch_maestro,'maestro.txt');
	assign(arch_detalle,'detalle.txt');
	assign(arch_text,'archtext.txt');
	rewrite(arch_maestro);
	rewrite(arch_detalle);
	cargarArchivoDetalle(arch_detalle);
	cargarArchivoMaestro(arch_maestro,arch_detalle);
	cargarArchivotext(arch_text,arch_detalle);
END.
	
