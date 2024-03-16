program Ejercicio4Practica1;
type
	empleado = record
		nro: integer;
		apellido:String[12];
		nombre:String[12];
		edad:integer;
		dni:integer;
		end;
	archivoText = text;
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
procedure agregarEmpleado(var arch:archivo);
var
	e:empleado;
begin
	reset(arch);
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
procedure modificarEdad(var arch:archivo);
var
	e:empleado;
	nroEmpleado,edad:integer;
begin
	writeln('Ingrese nroEmpleado');
	readln(nroEmpleado);
	reset(arch);
	while((not eof(arch)) and (nroEmpleado <> 0))do begin
		read(arch,e);
		writeln('Ingrese edad');
		readln(edad);
		e.edad:= edad;
		Seek(arch,FilePos(arch)-1);
		write(arch,e);
		writeln('Ingrese nroEmpleado');
		readln(nroEmpleado);
	end;
	close(arch);	
end;
procedure opcionF(var arch:archivo;var arch2:archivoText);
var
	e:empleado;
begin
	assign(arch2,'todos_empleados.txt');
	rewrite(arch2);
	reset(arch);
	while(not eof(arch)) do begin
		read(arch,e);
		writeln(arch2,'Nombre: ',e.nombre);
		writeln(arch2, 'Apellido: ',e.apellido);
		writeln(arch2, 'Numero: ',e.nro);
		writeln(arch2, 'Edad: ',e.edad);
		writeln(arch2, 'DNI: ',e.dni);
		writeln(arch2, ' ------------ ');
	end;
	close(arch);
	close(arch2);
end;
procedure opcionG(var arch:archivo; var arch3:archivoText);
var
	e:empleado;
begin
	assign(arch3,'faltaDNIEmpleado.txt');
	rewrite(arch3);
	reset(arch);
	while(not eof(arch)) do begin
		read(arch,e);
		if(e.dni = 00)then begin
			writeln(arch3,'Nombre: ',e.nombre);
			writeln(arch3, 'Apellido: ',e.apellido);
			writeln(arch3, 'Numero: ',e.nro);
			writeln(arch3, 'Edad: ',e.edad);
			writeln(arch3, 'DNI: ',e.dni);
			writeln(arch3, ' ------------ ');
		end;
	end;
	close(arch);
	close(arch3);
end;
var
	arch2:archivoText;
	arch3:archivoText;
	nombre:String[20];
	arch: archivo;
	opcion:integer;
	sdaOpcion:char;
begin
	assign(arch,'Ejercicio3.txt');
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
			writeln('b: Listar en pantalla los empleados de a uno por linea.');
			writeln('c: Listar en pantalla empleados mayores de 70, proximos a jubilarse.');
			writeln('d: Agregar empleados');
			writeln('e: Modificar edad empleados');
			writeln('f: Exportar contenido a todos_empleados.txt');
			writeln('g: Exportar a faltaDNIEmpleado.txt, los empleados que no tengan cargado el DNI.');
			readln(sdaopcion);
			if(sdaopcion = 'a')then
				opcionA(arch)
			else
				if(sdaopcion = 'b')then
					opcionB(arch)
				else
					if(sdaopcion = 'c')then
					opcionC(arch)
					else
						if(sdaopcion = 'd')then
							agregarEmpleado(arch)
						else
							if(sdaopcion = 'e')then
								modificarEdad(arch)
							else 
								if(sdaopcion = 'f')then begin									
									opcionF(arch,arch2)
								end
								else
									if(sdaopcion = 'g')then
										opcionG(arch,arch3)
			end;
		writeln('0: Crear archivo');
		writeln('1: Abrir archivo');
		writeln('2: Cerrar menu');
		readln(opcion);
	end;
END.
