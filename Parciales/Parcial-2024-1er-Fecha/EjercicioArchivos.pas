program Parcial20241Fecha;
const 
	valorAlto = 9999;
type
	prestamo = record
		nroSuc:integer;
		dni:string;
		nroPres:integer;
		fecha:string;
		monto:real;
		end;
	arch = file of prestamo;
	
procedure leerArchivo(var a:arch; var p:prestamo);
begin
	if(not eof(a))then
		read(a,p)
	else
		p.nroSuc := 9999;
end;

procedure crearInforme(var a:arch);
var
	at:text;
	p:prestamo;
	dni:string;
	suc,anio:integer;
	cant,cantVentTotalEmpl:integer;
	cantTotalVentSuc:integer;
	cantTotalVentEmpr:integer;
	monto,totalMontoEmpl:real;
	totalMontoSuc:real;
	totalMontoEmpr:real;
begin
	assign(at,'InformePrestamos.txt');
	rewrite(at);
	reset(a);
	leerArchivo(a,p);
	cantTotalVentEmpr:= 0;
	totalMontoEmpr:= 0;
	while(p.nroSuc <> valorAlto)do begin
		suc:= p.nroSuc;
		cantTotalVentSuc:= 0;
		totalMontoSuc:= 0;
		writeln(at,'Sucursal: ', suc);
		while(suc = p.nroSuc)do begin
			dni:= p.dni;
			cantVentTotalEmpl:= 0;
			totalMontoEmpl:= 0;
			writeln(at,'Empleado: DNI',dni);
			writeln('Anio			Cantidad de ventas 			Monto de ventas');
			while((suc = p.nroSuc)and(dni = p.dni))do begin
				monto:= 0;
				cant:= 0;
				anio:= extraerAnio(p.fecha); // Método provisto por la cátedra, asumir que existe.
				while((suc = p.nroSuc)and(dni = p.dni)and(anio = extraerAnio(p.fecha)))do begin
					cant:= cant + 1;
					monto := monto + p.monto;
				end;
				writeln(at,anio,'		',cant,'		',monto);
				cantVentTotalEmpl := cantVentTotalEmpl + cant;
				totalMontoEmpl := totalMontoEmpl + monto;
			end;
			writeln(at,'Totales: ',cantVentTotalEmpl,' ',totalMontoEmpl);
			cantTotalVentSuc:= cantTotalVentSuc + cantVentTotalEmpl;
			totalMontoSuc:= totalMontoSuc + totalMontoEmpl;
		end;
		writeln(at,'Cantidad total de ventas sucursal: ', cantTotalVentSuc);
		writeln(at,'Monto total vendido por sucursal: ', totalMontoSuc);
		cantTotalVentEmpr:= cantTotalVentEmpr + cantTotalVentSuc;
		totalMontoEmpr:= totalMontoEmpr + totalMontoSuc;
	end;
	writeln(at,'Cantidad total de ventas empresa: ', cantTotalVentEmpr);
	writeln(at,'Monto total vendido por empresa: ', totalMontoEmpr);
	close(a);
end;
var
	archivo : arch;
BEGIN
	assign(archivo,'prestamosOtorgados.txt');
	crearInforme(archivo);
END.
