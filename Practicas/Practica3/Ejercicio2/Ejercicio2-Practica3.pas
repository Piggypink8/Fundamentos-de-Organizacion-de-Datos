program Ejercicio2Practica3;
const
	valorAlto = 9999;
	delete = '***';
type
	asistente = record
		nro:integer;
		nomApe:string;
		email:string;
		tel:string;
		dni:string[8];
		end;
	maestro = file of asistente;
procedure crearMaestro(var am: maestro);
var
    at: text;
    a:asistente;
begin
    assign(at,'datosMaestro.txt');
    reset(at);
    reset(am);
    while(not eof(at)) do
        begin
            with a do
                begin
                    readln(at, nro);
                    readln(at, nomApe, email, tel, dni);
                    write(am, a);
                end;
        end;
    writeln('Archivo binario maestro creado');
    close(am);
    close(at);
end;
procedure leerMaestro(var am:maestro;var a:asistente);
begin
	if(not eof(am))then
		read(am,a)
	else
		a.nro:= valorAlto;
end;
procedure eliminar(var am:maestro);
var
	a:asistente;
	at:text;
begin
	assign(at,'eliminados.txt');
	rewrite(at);
	reset(am);
	leerMaestro(am,a);
	while(a.nro <> valorAlto)do begin
		if(a.nro < 1000)then begin
			a.nomApe:= delete;
			seek(am,filePos(am)-1);
			write(am,a);
			writeln(at,a.nro);
		end;
		leerMaestro(am,a)
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
	eliminar(am);
END.

