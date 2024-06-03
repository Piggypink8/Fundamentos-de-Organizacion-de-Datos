program Parcial2023Fecha2Tema1;
const
	valorAlto = 9999;
type
	equipo = record
		cod:integer;
		nombre:string;
		anio:integer;
		codTorneo:integer;
		codRival:integer;
		golesFavor:integer;
		golesContra:integer;
		puntos:integer;
		end;
		
	archivo = file of equipo;
procedure leerText(var at:text;var e:equipo);
begin
	if(not eof(at))then begin
		readln(at,e.nombre);
		readln(at,e.codTorneo, e.anio, e.cod);
		readln(at,e.codRival, e.golesFavor, e.golesContra, e.puntos);
	end
	else
		e.codTorneo := valorAlto;
end;
procedure crearArchivo(var a:archivo; var at:text);
var
	e:equipo;
begin
	reset(a);
	reset(at);
	leerText(at,e);
	while(e.codTorneo <> valorAlto)do begin
		write(a,e);
		leerText(at,e);
	end;
	close(at);
	close(a);
	writeln('Se creo el archivo binario correctamente');
end;
procedure leerArchivo(var a:archivo; var e:equipo);
begin
	if(not eof(a))then
		read(a,e)
	else
		e.anio := valorAlto;
end;
procedure imprimirArchivo(var a:archivo);
var
	e:equipo;
	equipoGanador,nombre:string;
	pMax,cantGoles,cantContra,diferencia,ganados,empatados,puntos,perdidos,codTorneo,cod,anio:integer;
	
begin
	reset(a);
	leerArchivo(a,e);
	while(e.anio <> valorAlto)do begin
		anio := e.anio;
		writeln('Anio ', anio);
		while(e.anio = anio)do begin
			pMax := -9999;
			codTorneo := e.codTorneo;
			writeln('	Codigo torneo ',codTorneo);
			while((e.anio = anio) and (codTorneo = e.codTorneo))do begin
				cod := e.cod;
				nombre:= e.nombre;
				cantGoles:= 0;
				cantContra := 0;
				puntos := 0;
				ganados := 0;
				empatados:= 0;
				perdidos:= 0;
				writeln('		Codigo equipo: ',cod,' nombre equipo: ', nombre);
				while((e.anio <> valorAlto) and (e.anio = anio) and (codTorneo = e.codTorneo) and (cod = e.cod))do begin
					puntos := puntos + e.puntos;
					cantGoles:= cantGoles + e.golesFavor;
					cantContra := cantContra + e.golesContra;
					if(e.golesFavor > e.golesContra)then
						ganados := ganados + 1
					else if(e.golesFavor = e.golesContra)then
						empatados:= empatados + 1
					else
						perdidos:= perdidos + 1;
					leerArchivo(a,e);
				end;
				diferencia := cantGoles - cantContra;
				writeln('			Cantidad total goles a favor equipo ',nombre,': ',cantGoles);
				writeln('			Cantidad total goles en contra equipo ',nombre,': ',cantContra);
				writeln('			Diferencia de goles: ', diferencia);
				writeln('			Cantidad de partidos ganados equipo ',nombre,': ',ganados);
				writeln('			Cantidad de  partidos perdidos equipo ',nombre,': ',perdidos);
				writeln('			Cantidad de partidos empatados equipo ',nombre,': ',empatados);
				writeln('			Cantidad de puntos equipo ',nombre,': ',puntos);
				writeln('			--------------------------------------');
				if(puntos > pMax)then begin
					equipoGanador := nombre;
					pMax:= puntos;
				end;
			end;
			writeln('			Equipo ganador del torneo ',codTorneo,' es: ',equipoGanador);
		end;
	end;
	close(a);
end;
var
	at:text;
	a:archivo;
BEGIN
	assign(at,'Equipos.txt');
	assign(a,'ArchivoEquipos.txt');
	rewrite(a);
	crearArchivo(a,at);
	imprimirArchivo(a);
END.
