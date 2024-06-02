program Ejercicio2Practica2;
type
	alumno = record
		cod:integer;
		nombre:String[5];
		matAprob:integer;
		curAprob:integer;
		end;
	aludet = record
		cod:integer;
		matAprob:integer;
		curAprob:integer;
	end;
	archivoText = text;
	maestro = file of alumno;
	detalle = file of aludet;
	
	
	{	Inciso A	}	
procedure leerArchivoTextoMaestro(var at:archivoText;var a:alumno);
begin
	if(not eof(at))then begin
		readln(at, a.cod, a.matAprob, a.curAprob);
		readln(at, a.nombre)
	end
	else
		a.cod:= 9999;
end;
procedure crearArchivoMaestro(var am:text;var at:archivoText);
var
	a:alumno;
begin
	rewrite(am);
	reset(at);
	leerArchivoTextoMaestroo(at,a);
	while(a.cod <> 9999)do begin
		write(am,a);
		leerArchivoTextoMaestro(at,a);	
	end;
	close(at);
	close(am);
end;

	{	Inciso B	}	
procedure leerArchivoTextoDetalle(var at:text;var a:aludet);
begin
	if(not eof(at))then
		readln(at, a.cod, a.matAprob, a.curAprob)
	else
		a.cod:= 9999;
end;
procedure crearArchivoDetalle(var ad:detalle; var at:text);
var
	a:aludet;
begin
	rewrite(ad);
	reset(at);
	leerArchivoTextoDetalle(at,a);
	while(a.cod <> 9999)do begin
		write(ad,a);
		leerArchivoTextoDetalle(at,a);
	end;
	close(at);
	close(ad);
end;

	{	Inciso C	}	
procedure litarArchivoMaestroEnReporte(var am:maestro; var at:text);
var
	a:alumno;
begin
	reset(am);
	rewrite(at);
	while(not eof(am))do begin
		read(am,a);
		writeln(at,'codigo: ',a.cod, ', cursadas aprobadas: ', a.curAprob, ', materias aprobadas: ', a.matAprob);
		writeln(at, ' nombre: ',a.nombre);
	end;
	close(at);
	close(am);
end;

	{	Inciso D	}
procedure litarArchivoDetalleEnReporte(var ad:detalle; var at:text);
var
	a:aludet;
begin
	reset(ad);
	rewrite(at);
	while(not eof(ad))do begin
		read(ad,a);
		writeln(at,'codigo: ',a.cod, ', cursadas aprobadas: ', a.curAprob, ', materias aprobadas: ', a.matAprob);
	end;
	close(at);
	close(ad);
end;

	{	Inciso E	}
	
procedure actualizarArchivoMaestro(var am:maestro;var ad:detalle);
var
	regd:aludet;
	regm:alumno;
begin
	reset(am);
	reset(ad);
	read(ad,regd);
	while(not eof(ad))do begin		
		read(am,regm);
		while(regm.cod = regd.cod)do begin
			regm.curAprob := regm.curAprob + regd.curAprob;
			regm.matAprob := regm.matAprob + regd.matAprob;
			read(ad,regd);
		end;
		seek(am,filepos(am)-1);
		write(am,regm);
	end;
	close(ad);
	close(am);
end;

// Aclaración: matAprob y curAprob guardan un 1 o un 0 para que sea directo.
// Preguntar: ¿Diferencia entre hacer el algoritmo con read o proceso leer archivo?, ¿Esta bien inciso E?

	{	Inciso F	}
procedure listarAlumnosCursadaAprobadaSinFinal(var am:maestro;var at:text);
var
	a:alumno;
begin
	rewrite(at);
	reset(am);
	while(not eof(am))do begin
		if(a.curAprob > 4 and a.matAprob = 0) thaen begin
			writeln(at, a.cod, ' ', a.curAprob, ' ', a.matAprob);
			writeln(at,a.nombre)
		end;
		read(am,a);
	end;
	close(am);
	close(at);
end;
var
	arch_maestro : maestro;
	arch_detalle : detalle;
	alumnos,detalleAlumnos,reporteAlumnos,reporteDetalle,listadoAlumnos : text;
BEGIN
	assign(alumnos,'alumnos.txt');
	assign(detalleAlumnos,'detalle.txt');
	
	assign(arch_maestro,'maestro.dat');
	assign(arch_detalle,'detalle.dat');
	

	assign(reporteAlumnos,'reporteAlumnos.txt');
	assign(reporteDetalle,'reporteDetalle.txt');
	assign(listadoAlumnos,'ListadoAlumnos.txt');
	
	rewrite(arch_maestro);
	rewrite(arch_detalle);
	
	crearArchivoDetalle(arch_detalle,detalleAlumnos);
	crearArchivoMaestro(arch_maestro,alumnos);
	
	listarArchivoMaestroEnReporte(arch_maestro,reporteAlumnos);
	listarArchivoDetalleEnReporte(arch_detalle,reporteDetalle);
	
	listarAlumnosCursadaAprobadaSinFinal(arch_maestro,listadoAlumnos);
END.
