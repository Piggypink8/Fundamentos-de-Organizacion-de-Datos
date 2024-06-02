program Ejercicio13Practica2;
const
	valorAlto = 'ZZZZ';
type
	fecha = record
		dia:integer;
		mes:integer;
		end;
	vuelo = record
		destino:string;
		f:fecha;
		hr:integer;
		asientos:integer;
		end;
	detalle = file of vuelo;
	maestro = file of vuelo;
	
procedure crearMaestro(var am: maestro);
var
    at: text;
    v:vuelo;
begin
    assign(at,'maestrotxt13.txt');
    reset(at);
    reset(am);
    while(not eof(at)) do
        begin
            with v do
                begin
                    readln(at, destino);
                    readln(at, v.f.mes, v.f.dia, hr);
                    readln(at, asientos);
                    write(am, v);
                end;
        end;
    writeln('Archivo binario maestro creado');
    close(am);
    close(at);
end;

procedure crearDetalle(var ad: detalle);
var
	n:string;
    at: text;
	v:vuelo;
begin
	writeln('Escriba nombre del archivo txt detalle');
	readln(n);
    assign(at, n);
    reset(at);
    reset(ad);
    
    while(not eof(at)) do
        begin
            with v do
                begin
                    readln(at, destino);
                    readln(at, v.f.mes, v.f.dia, hr);
                    readln(at, asientos);
                    write(ad, v);
                end;
        end;
    writeln('Archivo binario detalle creado');
    close(ad);
    close(at);
end;
procedure leerMaestro(var am:maestro;var v:vuelo);
begin
	if(not eof(am))then
		read(am,v)
	else
		v.destino := valorAlto;
end;

// ---> continuar proceso,
// ---> consulta: puede haber vuelos para un mismo destino con distintas fechas?
// ---> vuelos con destino a argentina en 3 fechas distintas por ejemplo.
procedure actualizarMaestro(var am;var ad1,ad2:detalle);
var
	regm:vuelo;
begin
	
end;
procedure listaVuelos(var am:maestro; cant:integer);
var
	at:text;
	v:vuelo;
begin
	assign(at,'listaVuelo.txt');
	rewrite(at);
	reset(am);
	leerMaestro(am,v);
	while(v.destino <> valorAlto)do begin
		if(v.asientos < cant)then begin
			writeln(at,v.destino);
			writeln(at,v.f.dia,'/',v.f.mes,' ', v.hr,'hs');
		end;
		leerMaestro(am,v);
	end;
	writeln('Archivo listado de vuelos creado');
	close(am);
	close(at);
end;
var
	am:maestro;
	ad,ad2:detalle;
	cant:integer;
BEGIN
	assign(am,'maestro13.txt');
	rewrite(am);
	assign(ad,'detallebinario1-13.txt');
	assign(ad2,'detallebinario2-13.txt');
	rewrite(ad);
	rewrite(ad2);
	crearDetalle(ad);
	crearDetalle(ad2);
	crearMaestro(am);
	writeln('Ingrese cantidad de asientos');
	readln(cant);
	listaVuelos(am,cant);
END.
{
destino := v.destino;
		while(destino = v.destino)do begin
			mes:= v.f.mes;
			while(mes = v.f.mes)do begin
				dia:= v.f.dia;
				while((mes = v.f.mes) and (dia = v.f.dia)) do begin
					
				end;
			end;
		end;
}
