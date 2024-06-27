program Ejercicio8Practica3;
const
	valorAlto = 9999;
type
	distribucion = record
		nombre:string[10];
		anio:integer;
		version:integer;
		cantDevs:integer;
		desc:integer;
		end;
	maestro = file of distribucion;
procedure leerDistribucion(var d:distribucion);
begin
	readln(d.anio);
	if(d.anio <> 0)then begin
		readln(d.nombre);
		readln(d.version);
		readln(d.cantDevs);
		readln(d.desc);
	end;
end;
procedure crearMaestro(var am:maestro);
var
	d:distribucion;
begin
	reset(am);
	d.anio := 0;
	write(am,d);
	leerDistribucion(d);
	while(d.anio <> 0)do begin
		write(am,d);
		leerDistribucion(d);
	end;
	close(am);
end;
procedure leerArchivo(var am:maestro; var d:distribucion);
begin
	if(not eof(am))then
		read(am,d)
	else
		d.anio:= valorAlto;
function existeDistribucion(var am:maestro;nombre:string[10]):boolean;
var
	d:distribucion;
begin
	reset(am);
	leerArchivo(am,d);
	while(d.nombre <> valorAlto and d.nombre <> nombre)do 
		leerArchivo(am,d);
	if(d.nombre = nombre)then
		existeDistribucion := true;
	else 
		existeDistribucion:= false;
end;
procedure altaDistribucion(var am:maestro);
var
	pos:integer;
	cab,nue:distribucion;
begin
	reset(am);
	leerDistribucion(nue);
	if(existeDistribucion(nue.nombre))then begin
		leerArchivo(am,cab);
		if(cab.cantDevs < 0)then begin
			pos:= cab.canDevs * -1;
			seek(am,pos);
			read(am,cab);
			seek(am,pos);
			write(am,nue);
			seek(am,0);
			write(am,cab);
		end
		else
			seek(am,filesize(am));
			write(am,nue);
	end
	else
		writeln('Ya existe la distribucion');
	close(am);
end;
procedure bajaDistribucion(var am:maestro);
var
	nombre:string[10];
	cab,reg:distribucion
	pos:integer;
begin
	reset(am);
	writeln('Ingrese nombre a dar de baja');
	readln(nombre);
	leerArchivo(am,cab);
	leerArchivo(am,reg);
	while(reg.anio <> valorAlto and reg.nombre <> nombre) do
		leerArchivo(am,reg);
	if(reg.nombre = nombre)then begin
		pos:= (filepos(am)-1) * -1;
		seek(am,filepos(am)-1);
		write(am,cab);
		seek(am,0);
		reg.cantDevs := pos;
		write(am,reg);
	end
	else
		writeln('No existe el nombre ingresado');
	
	
	close(am);
end;
var
BEGIN
	
END.
