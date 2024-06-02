
program 
const
	valorAlto = 9999;
type
	fecha = record
		anio:integer;
		mes:integer;
		dia:integer;
		end;
	cliente = record
		cod:integer;
		nomApe:string;
		f:fecha;
		monto:integer;
		end;
	maestro = file of cliente;
	
procedure leerMaestro(var am:maestro;var c:cliente);
begin
	if(not eof(am))then
		read(am,c);
	else
		c.cod := valorAlto;
end;
var
	at:text;
	am:maestro;
	act,regM:cliente;
BEGIN
	assign(am,'maestro.txt');
	reset(am);
	leerMaestro(am,regM);
	while(regM.cod <> valorAlto)do begin
		act:= regM;
		while(act.cod = regM.cod)do begin // como el dia es irrelevante y se necesita mes a mes, no lo agrego.
			while((act.f.anio = regM.f.anio)and(act.f.mes = regM.f.mes))do begin
				
				leerMaestro(am,regM);
			end;
			writeln(at,regM);
		end;
	end;
	
	close(am);
END.

// (las localidades pueden o no haber sido actualizadas <<- explicar
