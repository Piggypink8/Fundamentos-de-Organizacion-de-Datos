program Ejercicio7Practica3;
const
	valorAlto = 9999;
type
	ave = record
		cod:integer;
		esp:string[20];
		famAve:string[20];
		desc:string[20];
		zona:string[15];
		end;
	maestro = file of ave;
procedure leerAve(var a:ave);
begin
	readln(a.cod);
	if(a.cod <> 0)then begin
		readln(a.esp);
		readln(a.famAve);
		readln(a.desc);
		readln(a.zona)
	end;
end;
procedure crearArchivo(var am:maestro);
var
	a:ave;
begin
	reset(am);
	leerAve(a);
	while(a.cod<>0)do begin
		write(am,a);
		leerAve(a);
	end;
	close(am);
end;
procedure leerMaestro(var am:maestro;var a:ave);
begin
	if(not eof(am))then
		readln(am,a)
	else
		a.cod:= valorAlto;
end;
procedure bajarAves(var am:maestro);
var
	pos,cod:integer;
	a:ave;
begin
	reset(am);
	readln(cod);
	leerAve(am,p);
	while(p.cod <> valorAlto and p.cod <> c)do 
		leerAve(am,a);
	if(a.cod = cod) then begin
		pos:= (filepos(am)-1) * -1;
		seek(am,filepos(am)-1);
		a.cod:= pos;
		write(am,p);
		eliminarAve(am);
		readln(cod);
	end
	else
		seek(am,0);
end;
	close(ad);
	close(am);
end;
procedure eliminarAve(var am:maestro);
var
	a:ave;
	pos,cod:integer
begin
	leerMaestro(am,a);
	while(a.cod > 0) do
		leerMaestro(am,a);
	if(a.cod <= 0)then begin
		pos:= filepos(am) - 1;
		seek(am,filesize(am)-1);
		leerMaestro(am,a);
		seek(am,pos);
		write(am,a);
		seek(am,filesize(am)-1);
		truncate(am);
	end
	else
		seek(am,0);
end;
var
	am:maestro;
BEGIN
	assign(am,'maestro.txt');
	rewrite(am);
	crearArchivo(am);
	bajarAves(am);
END.
