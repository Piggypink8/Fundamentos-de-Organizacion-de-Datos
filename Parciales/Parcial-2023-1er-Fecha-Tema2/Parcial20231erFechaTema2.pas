program Parcial1erFecha2023;
const
	valorAlto = 9999;
type
	empleado = record
		dni:integer;
		nomApe:string;
		edad:integer;
		domicilio:string;
		fechaNac:string;
		end;
		
	archivo = file of empleado;
procedure leerEmpleado(var e:empleado);
begin
	writeln('Ingrese dni');
	readln(e.dni);
	if(e.dni <> -1)then begin
		writeln('Ingrese nombre y apellido');
		readln(e.nomApe);
		writeln('Ingrese edad');
		readln(e.edad);
		writeln('Ingrese domicilio');
		readln(e.domicilio);
		writeln('Ingrese fecha nacimiento');
		readln(e.fechaNac);
	end;
end;
procedure leerArchivo(var a:archivo; var e:empleado);
begin
	if(not eof(a))then
		read(a,e)
	else
		e.dni := valorAlto;
end;
function existeEmpleado(var a:archivo;e:empleado):integer
var
	pos:integer
	reg:empleado;
begin
	reset(a);
	leerArchivo(a,reg);
	
	while(reg.dni <> valorAlto and reg.dni <> e.dni)do begin
		leerArchivo(a,reg);
	end;
	
	if(reg.dni = valorAlto)then
		pos:= 0
	else 
		pos:= filepos(a)-1;
		
	close(a);
	
	existeEmpleado := pos;
end;
procedure agregarEmpleado(var a:archivo);
var
	cab,e:empleado
	pos:integer;
begin
	reset(a);
	
	leerEmpleado(e);
	if(existeEmpleado(a,e) = 0) then begin
		leerArchivo(a,cab);
		if(cab.dni = 0)then begin // No hay espacio
			seek(a,filesize(a)-1);
			write(a,e);
		end
		else begin	// Hay espacio 
			pos := cab.dni * -1;
			seek(a,pos);
			read(a,cab);
			seek(a,pos);
			write(a,e);
			seek(a,0);
			write(a,cab);
		end;
	end
	else
		writeln('Ya existe el empleado');
	close(a);
end;
procedure quitarEmpleado(var a:archivo);
var
	e,cab:empleado;
	pos:integer
begin
	reset(a);
	writeln('Ingrese dni');
	readln(e.dni);
	leerArchivo(a,cab);
	pos := existeEmpleado(a,e); // retorna la pos si existe, caso contrario 0
	if( pos > 0)then begin
		seek(a,pos);
		read(a,e);
		e.dni := e.dni * -1;
		seek(a,pos);
		write(a,cab);
		seek(a,0);
		write(a,e);
	end
	else
		writeln('El empleado no existe');
	close(a);
end;
var
	a:archivo;
BEGIN
	assign(a,'archivo.txt');
	rewrite(a);
	agregarEmpleado(a);
	quitarEmpleado(a);
END.

