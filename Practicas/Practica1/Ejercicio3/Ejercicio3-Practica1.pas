program Ejercicio3Practica1;
type
	empleado = record
		nro: integer;
		apellido:String[12];
		nombre:String[12];
		edad:integer;
		dni:integer;
		end;
	archivo = file of empleado;
	
procedure leerEmpleado(var e:empleado);
begin
	writeln('Ingrese apellido');
	readln(e.apellido);
	if(e.apellido <> 'fin')then begin
	writeln('Ingrese nombre');
	readln(e.nombre);
	writeln('Ingrese dni');
	readln(e.dni);
	writeln('Ingrese nro');
	readln(e.nro);
	writeln('Ingrese edad');
	readln(e.edad);
	end;
end;
procedure agregarArchivo(var arch:archivo);
var
	e:empleado;
begin
	leerEmpleado(e);
	while(e.apellido <> 'fin')do begin
		write(arch, e);
		leerEmpleado(e);
	end;
	close(arch);
end;
procedure opcionA(var arch:archivo);
var
	e:empleado;
	nombre,apellido:String[12];
begin
	writeln('Ingrese nombre');
	readln(nombre);
	writeln('Ingrese apellido');
	readln(apellido);
	reset(arch);
	writeln('Lista empleados con nombre "', nombre, '" o apellido "', apellido,'"');
	while(not eof(arch))do begin
		read(arch,e);
		if((e.nombre = nombre) or (e.apellido = apellido))then
			writeln(e.nombre,' ', e.apellido);
	end;
	close(arch);
end;
procedure opcionB(var arch:archivo);
var
	e:empleado;
begin
	reset(arch);
	writeln('Lista empleados');
	while(not eof(arch))do begin
		read(arch,e);
		writeln(e.nombre, ' ', e.apellido, ', ', e.edad, ' anios, dni: ', e.dni, ', nro: ', e.nro);
	end;
	close(arch);
end;
procedure opcionC(var arch:archivo);
var
	e:empleado;
begin
	reset(arch);
	writeln('Lista empleados mayores a 70');
	while(not eof(arch))do begin
		read(arch,e);
		if(e.edad > 70) then
			writeln(e.nombre, ' ', e.apellido, ', ', e.edad, ' anios, dni: ', e.dni, ', nro: ', e.nro);
	end;
	close(arch);
end;
var
	nombre:String[20];
	arch: archivo;
	opcion:integer;
	sdaOpcion:char;
begin
	writeln('0: Crear archivo');
	writeln('1: Abrir archivo');
	writeln('2: Cerrar menu');
	readln(opcion);
	while(opcion <> 2)do begin
		if(opcion = 0)then begin
			writeln('Ingrese nombre del archivo');
			readln(nombre);
			assign(arch, nombre);
			rewrite(arch);
			agregarArchivo(arch);
		end
		else
			if(opcion = 1)then begin
			writeln('a: Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.');
			writeln('b: Listar en pantalla los empleados de a uno por línea.');
			writeln('c: Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.');
			readln(sdaopcion);
			if(sdaopcion = 'a')then
				opcionA(arch)
			else
				if(sdaopcion = 'b')then
					opcionB(arch)
				else
					opcionC(arch)
			end;
		writeln('0: Crear archivo');
		writeln('1: Abrir archivo');
		writeln('2: Cerrar menu');
		readln(opcion);
	end;
END.
