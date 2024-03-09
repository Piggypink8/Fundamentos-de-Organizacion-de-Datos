program Ejercicio2Practica1;
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
	cant,prom,num:integer;
begin
	reset(arch);
	cant:= 0;
	prom:= 0;
	while(not eof(arch))do begin
		read(arch,num);	
		prom:= prom + num;
		if(num < 1500)then
			cant := cant + 1;
		writeln(num);
	end;
	writeln('Cantidad numeros menor a 1500: ', cant);
	writeln('Promedio de los numeros ingresados: ', prom/FileSize(arch):2:2);
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
	writeln('Contenido del archivo');
	mostrarArchivo(arch);
END.
