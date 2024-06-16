program Ejercicio2Parte2Practica3;
const
	valorAlto = 9999;
type
	mesa = record
		nro:integer;
		cod:integer;
		votos:integer;
		end;
	archivo = file of mesa;
procedure leerMesa(var m:mesa);
begin
	readln(m.nro);
	if(m.nro <> 0)then begin
		readln(m.cod);
		readln(m.votos);
	end;
end;
procedure crearArchivo(var a:archivo);
var
	m:mesa;
begin
	reset(a);
	leerMesa(m);
	while(m.nro <> 0) do begin
		write(a,m);
		leerMesa(m);
	end;
	close(a);
end;
procedure leerArchAux(var aux:archivo; var m:mesa);
begin
	if(not eof(aux))then
		read(aux,m)
	else
		m:= valorAlto;
end;
function existeMesaAux(var aux:archivo; m:mesa):boolean;
var
	maux:mesa;
	encontre: boolean;
begin
	encontre := false;
	reset(aux);
	leerArchAux(aux,maux);
	while(maux.cod <> valorAlto and not encontre) do begin
		if(maux.cod = m.cod)then
			encontre := true;
		leerArchAux(aux,maux);
	end;
	close(aux);
	existeMesaAux:= encontre;
end;
procedure agregarAux(var aux:archivo; m:mesa);
begin
	reset(aux);
	seek(aux,filesize(aux)-1);
	write(aux,m);
	close(aux);
end;
procedure crearArchivoAux(var a,aux:archivo);
var
	m,maux:mesa;
begin
	reset(a);
	leerArchivo(a,m);
	while(a.cod <> valorAlto)do begin
		if(not existeMesaAux(aux,m))then
			agregarAux(aux,m);
		leerArchivo(a,m);
	end;
	close(a);
end;
var	
	a:archivo;
	aux:archivo;
	mAux,m:mesa;
	act,total,totalGral:integer;
BEGIN
	crearArchivo(a);
	crearArchivoAux(a,aux);
	reset(aux);
	reset(a);
	leerArchAux(aux,mAux);
	totalGral := 0;
	while(mAux.cod <> valorAlto) do begin
		leerArchivo(a,m);
		act := m.cod * -1;
		m.cod := act;
		seek(a,filepos(a)-1);
		write(a,m);
		total := 0;
		while(m.cod <> valorAlto) do begin
			if(m.cod = mAux.cod)then begin
				total:= total + m.votos;
				m.cod := act;
				seek(a,filepos(a)-1);
				write(a,m);
			end;
			leerArchivo(a,m);
		end;
		seek(a,0);
		leerArchivo(a,m);
		while(m.cod <> act * -1) do begin
			if(m.cod = mAux.cod) then begin
				total:= total + m.votos;
				m.cod := act;
				seek(a,filepos(a)-1);
				write(a,m);
			end;
			leerArchivo(a,m);
		end;
		totalGral := totalGral + total;
		writeln('Codigo de localidad			Total de Votos');
		writeln(mAux.cod,'					',total);
		leerArchAux(aux,mAux);
	end;
	writeln('Total General de Votos 		',totalGral);
END.
