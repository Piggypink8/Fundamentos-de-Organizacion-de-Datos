program Ejercicio12Practica2;
const 
	valorAlto = 9999;
type
	usuario = record
		nro:integer;
		nomUsu:string;
		nomApe:string[4];
		cantMailEnv:integer;
		end;
	usuD = record
		nro:integer;
		destino:string;
		msj:string;
		end;
		
	detalle = file of usuD;
	maestro = file of usuario;

procedure leerDetalle(var ad:detalle; var u:usuD);
begin
	if(not eof(ad))then
		read(ad,u)
	else
		u.nro := valorAlto;
end;

procedure leerMaestro(var am:maestro; var u:usuario);
begin
	if(not eof(am))then
		read(am,u)
	else
		u.nro := valorAlto;
end;
procedure crearMaestro(var am: maestro);
var
    at: text;
    u:usuario;
begin
    assign(at,'logmail.txt');
    reset(at);
    reset(am);
    while(not eof(at)) do
        begin
            with u do
                begin
                    readln(at, nro, cantMailEnv);
                    readln(at, nomApe, nomUsu);
                    write(am, u);
                end;
        end;
    writeln('Archivo binario maestro creado');
    close(am);
    close(at);
end;

procedure crearDetalle(var ad: detalle);
var
    at: text;
    u:usuD;
begin
    assign(at, 'cargadetalle.txt');
    reset(at);
    reset(ad);
    
    while(not eof(at)) do
        begin
            with u do
                begin
                    readln(at, nro, destino);
                    readln(at, msj);
                    write(ad, u);
                end;
        end;
    writeln('Archivo binario detalle creado');
    close(ad);
    close(at);
end;
procedure actualizarMaestro(var am:maestro; var ad:detalle);
var
	ud:usuD;
	um:usuario;
begin
	reset(ad);
	reset(am);
	leerDetalle(ad,ud);
	while(ud.nro <> valorAlto)do begin
		leerMaestro(am,um);
		while(um.nro <> ud.nro) do
			leerMaestro(am,um);
		while(um.nro = ud.nro)do begin
			um.cantMailEnv := um.cantMailEnv + 1;
			leerDetalle(ad,ud);
		end;
		seek(am,filepos(am)-1);
		write(am,um);
	end;
	close(am);
	close(ad);
end;

procedure listarMaestro(var am:maestro;var at:text);
var
	u:usuario;
	name:string;
begin
	reset(am);
	writeln('Ingrese nombre archivo texto para listar maestro');
	readln(name);
	assign(at,name);
	rewrite(at);
	leerMaestro(am,u);
	while(u.nro <> valorAlto)do begin
		writeln(at,u.nro,' ',u.cantMailEnv);
		writeln(at,u.nomApe,' ',u.nomUsu);
		leerMaestro(am,u)
	end;
	close(am);
    close(at);
end;
var
	am:maestro;
	ad:detalle;
	at:text;
BEGIN
	assign(am,'maestro12.txt');
	rewrite(am);
	assign(ad,'detalle12.txt');
	rewrite(ad);
	crearDetalle(ad);
	crearMaestro(am);
	listarMaestro(am,at);
	actualizarMaestro(am,ad);
	listarMaestro(am,at);
END.
