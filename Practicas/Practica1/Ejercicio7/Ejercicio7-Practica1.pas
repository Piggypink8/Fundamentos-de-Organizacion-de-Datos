program Ejercicio7Practica1;
type
	novela = record
		cod:integer;
		nombre:String[20];
		genero:String[20];
		precio:real;
		end;
		
	archivoText = text;
	archivo = file of novela;
procedure leerNovela(var n:novela);
begin
	writeln('Ingrese codigo');
	readln(n.cod);
	if(n.cod <> 0)then begin
		writeln('Ingrese precio');
		readln(n.precio);
		writeln('Ingrese nombre');
		readln(n.nombre);
		writeln('Ingrese genero');
		readln(n.genero);
	end;
end;
procedure crearArchivoText(var archTxt:archivoText);
var
	n:novela;
begin
	rewrite(archTxt);
	leerNovela(n);
	while(n.cod <> 0) do begin
		writeln(archTxt, n.cod, ' ', n.precio:2:2, ' ', n.genero);
		writeln(archTxt, n.nombre);
		leerNovela(n);
	end;
	close(archTxt);
end;

procedure modificarNovela(var arch:archivo);
var
	encontre:boolean;
	precio,cod:integer;
	n:novela;
begin
	reset(arch);
	encontre:= false;
	writeln('Ingrese codigo de la novela');
	readln(cod);
	while(not encontre)do begin
		read(arch,n);
		if(n.cod = cod)then begin
			encontre := true;
			writeln('Ingrese precio');
			readln(precio);
			n.precio := precio;
		end;
	end;
	close(arch);
end;
procedure agregarNovela(var arch:archivo);
var
	n:novela;
begin
	reset(arch);
	seek(arch, fileSize(arch));
	leerNovela(n);
	write(arch,n);
	close(arch);
end;
procedure crearArchivo(var arch:archivo; var archTxt:archivoText);
var
	n:novela;
begin
	reset(arch);
	reset(archTxt);
	while(not eof(archTxt))do begin
		readln(archTxt, n.cod, n.precio, n.genero);
		readln(archTxt,n.nombre);
		write(arch,n);
	end;
	close(archTxt);
	close(arch)
end;
procedure modificarArchivo(var arch:archivo);
var
	opcion:integer;
begin
	writeln('0: Agregar novela');
	writeln('1: Modificar novela');
	readln(opcion);
	if(opcion = 0)then
		agregarNovela(arch)
	else
		modificarNovela(arch);
end;
var
	arch:archivo;
	arch2:archivoText;
	nombre:String[20];
begin
	assign(arch2, 'novelas.txt');
	writeln('Ingrese nombre del archivo txt');
	readln(nombre);
	assign(arch,nombre);
	rewrite(arch);
	crearArchivoText(arch2);
	crearArchivo(arch,arch2);
	modificarArchivo(arch);
END.
