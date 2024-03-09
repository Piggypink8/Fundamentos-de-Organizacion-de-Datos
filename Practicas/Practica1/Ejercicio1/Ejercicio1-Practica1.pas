program Ejercicio1Practica1;
type
	archivo = file of integer;
procedure agregarArchivo(var arch:archivo);
var
	num:integer;
begin
	writeln('Ingrese un numero');
	readln(num);
	while(num <> 30000)do begin
		write(arch, num);
		writeln('Ingrese un numero');
		readln(num);
	end;
	close(arch);
end;
procedure mostrarArchivo(var arch:archivo);
var
	num:integer;
begin
	reset(arch);
	while(not eof(arch))do begin
		read(arch,num);
		write(num);
	end;
	close(arch);
end;
var
	nombre:String[20];
	arch: archivo;
begin
	writeln('Ingrese nombre del archivo');
	readln(nombre);
	assign(arch, nombre);
	rewrite(arch);
	agregarArchivo(arch);
	mostrarArchivo(arch);
END.
