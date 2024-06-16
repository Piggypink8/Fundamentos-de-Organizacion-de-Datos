program Ejercicio2Practica3;
const
	valorAlto = 9999;
	delete = '***';
type
	novela = record
		cod:integer;
		genero:string;
		nombre:string;
		director:string;
		duracion:integer;
		precio:integer;
		end;
	maestro = file of novela;
procedure leerNovela(var n:novela);
begin
	writeln('Ingrese codigo');
	readln(n.cod);
	if(n.cod <> 0)then begin
		writeln('Ingrese genero');
		readln(n.genero);
		writeln('Ingrese nombre');
		readln(n.nombre);
		writeln('Ingrese director');
		readln(n.director);
		writeln('Ingrese duracion');
		readln(n.duracion);
		writeln('Ingrese precio');
		readln(n.precio);
	end;
end;
procedure crearMaestro(var am: maestro);
var
	n:novela;
begin
    reset(am);
    n.cod:= 0;
    write(am,n);
    leerNovela(n);
    while(n.cod <> 0) do begin
		write(am,n);
		leerNovela(n);
    end;
    writeln('Archivo binario maestro creado');
    close(am);
end;
procedure leerMaestro(var am:maestro;var n:novela);
begin
	if(not eof(am))then
		read(am,n)
	else
		n.cod:= valorAlto;
end;
procedure darAlta(var am:maestro);
var
	pos:integer;
	nCab,nNue:novela;
begin
	reset(am);
	leerNovela(nNue);
	leerMaestro(am,nCab);
	if(nCab.cod < 0) then begin
		pos:= nCab.cod * -1;
		seek(am,pos);
		read(am,nCab);
		seek(am,filePos(am)-1);
		write(am,nNue);
		seek(am,0);
		write(am,nCab);
	end
	else begin
		seek(am,filesize(am));
		write(am,nNue);
	end;
	close(am);
end;
procedure darBaja(var am:maestro);
var
	cab,reg:novela;
	cod,pos:integer;
begin
	reset(am);
	writeln('Ingrese codigo a dar de baja');
	readln(cod);
	leerMaestro(am,cab);
	leerMaestro(am,reg);
	while((reg.cod <> valorAlto) and (reg.cod <> cod))do begin
		leerMaestro(am,reg);
	end;
	if(reg.cod = cod) then begin
		pos:= (filePos(am)-1) * -1;
		seek(am,filepos(am)-1);
		write(am,cab);
		seek(am,0);
		reg.cod := pos;
		write(am,reg);
	end
	else
		writeln('El codigo no existe');
	close(am);
end;
procedure actualizarMaestro(var am:maestro);
var
	cod,opcion:integer;
	n:novela;
begin
	reset(am);
	writeln('Ingrese codigo para actualizar');
	readln(cod);
	leerMaestro(am,n);
	while((n.cod <> valorAlto) and (n.cod <> cod))do
		leerMaestro(am,n);
	
	if(n.cod = cod)then begin
		seek(am,filepos(am)-1);
		writeln('1 : modificar genero');
		writeln('2 : modificar nombre');
		writeln('3 : modificar duracion');
		writeln('4 : modificar director');
		writeln('5 : modificar precio');
		readln(opcion);
		case opcion of
			1 : begin
				write('Ingrese nuevo genero ');
				readln(n.genero);
				end;
			2 : begin
				write('Ingrese nuevo nombre ');
				readln(n.nombre);
				end;
			3 : begin
				write('Ingrese nueva duracion ');
				readln(n.duracion);
				end;
			4 : begin
				write('Ingrese nuevo director ');
				readln(n.director);
				end;
		 	5 : begin
				write('Ingrese nuevo precio ');
				readln(n.precio);
				end;
		end;
		write(am,n);
	end
	else
		writeln('El codigo no existe');
	close(am);
	
end;
procedure listarMaestro(var am:maestro);
var
	at:text;
	n:novela;
begin
	assign(at,'listaMaestro.txt');
	rewrite(at);
	reset(at);
	reset(am);
	leerMaestro(am,n);
	while(n.cod <> valorAlto)do begin
		writeln(at, n.cod,' ', n.precio);
		writeln(at, n.genero);
		leerMaestro(am,n);
	end;
	close(am);
	close(at);
end;
var
	am:maestro;
BEGIN
	assign(am,'maestro.txt');
	rewrite(am);
	crearMaestro(am);
	darBaja(am);
	darAlta(am);
	actualizarMaestro(am);
	listarMaestro(am);
END.

