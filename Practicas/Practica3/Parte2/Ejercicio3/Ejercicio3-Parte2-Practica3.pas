program Ejercicio3Parte2Practica3;
const 
	valorAlto = 9999;
type
	usuarioM = record
		cod:integer;
		fecha:integer;
		tiempo:integer;
		end;
	usuarioD = record
		cod:integer;
		fecha:integer
		total:integer;
		end;
	maestro = file of usuarioM;
	detalle = file of usuarioD;
	arrD = array[1..5] of detalle;
	
procedure leerMaestro(var am:maestro; var u:usuarioM);
begin
	if(not eof(am))then
		read(am,u)
	else
		u.cod:= valorAlto;
end;
procedure leerDetalle(var ad:detalle; var u:usuarioD);
begin
	if(not eof(ad))then
		read(ad,u)
	else
		u.cod:= valorAlto;
end;
function existeCodMaestro(var am:maestro; cod:integer):boolean;
var
	usuM:usuarioM;
	encontre: boolean;
begin
	encontre := false;
	reset(am);
	leerMaestro(am,usuM);
	while(usuM.cod <> valorAlto and not encontre) do begin
		if(usuM.cod = cod)then
			encontre := true;
		leerMaestro(am,usuM);
	end;
	close(am);
	existeCodMaestro:= encontre;
end;
procedure contarHorasDetalleCodigo(var ad:detalle; var regm:usuarioM):
var
	total, pos:integer;
	regd:usuarioD;
begin
	reset(ad);
	total := 0;
	leerDetalle(ad,regd);
	while(regd.cod <> valorAlto)do begin
		if(regd.cod = regm.cod)then begin
			regm.total := regm.total + regd.tiempo;
			pos := filepos(ad) - 1;
		end;
		leerDetalle(ad,regd);
	end;
	seek(regd,pos);
	read(ad,regd);
	regm.fecha := regd.fecha;
	close(ad);
end;
var
	i,:integer;
	arrD: arrD;
	am:maestro;
	regm:usuarioM;
	regd:usuarioD
BEGIN
	assign(am,'maestro.txt');
	reset(am);
	// Cargo todos los codigos de los detalles en el maestro
	for i:= 1 to 5 do begin
		leerDetalle(arrD[i],regd);
		while(regd.cod <> valorAlto)do begin
			if(not existeCodMaestro(am,regd.cod))then begin
				regm.cod := regd.cod;
				regm.total := 0;
				write(am,regm);
			end;
			leerDetalle(ad,regd);
		end;
	end;
	// Recorro el maestro y de ahi voy leyendo los detalles
	seek(am,0);
	leerMaestro(am,regm)
	while(regm.cod <> valorAlto) do begin
		for(i := 1 to 5) do begin
			contarHorasDetalleCodigo(arrD[i],regm);
		end;
		seek(am,filepos(am)-1);
		write(am,regm);
		leerMaestro(am,regm);
	end;
	close(am);
END.
