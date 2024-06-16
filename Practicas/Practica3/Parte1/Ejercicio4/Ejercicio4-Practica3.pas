program Ejercicio4Practica3;
const 
	valorAlto = 9999;
type
	reg_flor = record
		nombre: String[45];
		codigo:integer;
	end;
	tArchFlores = file of reg_flor;

procedure leerArchivo(var a:tArchFlores; var f:reg_flor);
begin
	if(not eof(a))then
		read(a,f)
	else
		f.codigo := valorAlto;
end;
{Abre el archivo y agrega una flor, recibida como parámetro
manteniendo la política descrita anteriormente}
procedure agregarFlor (var a: tArchFlores; nombre: string; codigo:integer);
var
	cab,reg:reg_flor;
	pos:integer;
begin
	reset(a);
	leerArchivo(a,cab);
	reg.codigo:= codigo;
	reg.nombre := nombre;
	if(cab.codigo < 0) then begin
		pos:= cab.codigo * -1;
		seek(a,pos);
		read(a,cab);
		seek(a,filepos(a)-1);
		write(a,reg);
		seek(a,0);
		write(a,cab);
	end
	else begin
		seek(a,filesize(a));
		write(a,reg);
	end;
	close(a);
end;
procedure leerFlor(var f:reg_flor);
begin
	writeln('Ingrese codigo');
	readln(f.codigo);
	if(f.codigo <> 0) then begin
		writeln('Ingrese nombre');
		readln(f.nombre);
	end;
end;
procedure eliminarFlor(var a:tArchFlores; cod:integer);
var
	pos:integer;
	cab,reg:reg_flor;
begin
	reset(a);
	leerArchivo(a,cab);
	leerArchivo(a,reg);
	while(reg.codigo <> cod)do
		leerArchivo(a,reg);
	pos:= (filepos(a)-1) * -1;
	reg.codigo := pos;
	seek(a,filepos(a)-1);
	write(a,cab);
	seek(a,0);
	write(a,reg);
	close(a);
end;
procedure imprimirArchivo(var a:tArchFlores);
var
	at:text;
	f:reg_flor;
begin
	reset(a);
	assign(at,'listadoFlores.txt');
	rewrite(at);
	leerArchivo(a,f);
	while(f.codigo <> valorAlto) do begin
		if(f.codigo > 0) then begin
			writeln(at,f.codigo);
			writeln(at,f.nombre);
		end;
		leerArchivo(a,f);
	end;
	close(at);
	close(a);
end;
var
	a:tArchFlores;
	nombre:string;
	codigo:integer;
BEGIN
	assign(a,'archivoFlores.txt');
	rewrite(a);
	writeln('Ingrese codigo');
	readln(codigo);
	writeln('Ingrese nombre');
	readln(nombre);
	while(codigo <> 0) do begin
		agregarFlor(a,nombre,codigo);
		writeln('Ingrese codigo');
		readln(codigo);
		writeln('Ingrese nombre');
		readln(nombre);
	end;
	imprimirArchivo(a);
END.
