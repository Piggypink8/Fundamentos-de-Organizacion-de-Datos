program Parcial2019PrimerFecha;
const
	n = 3
	valorAlto = 9999;
type
	venta = record
		cod:integer;
		name:string;
		fecha:integer;
		cantVend:integer;
		pago:string;
		end;
	
	arch = file of venta;
	
	arrRV = array[1..n] of venta;
	arrD = array[1..n] of arch;
	
procedure leerArchivo(var a:arch; var v:venta);
begin
	if(not eof(a))then
		read(a,v)
	else
		v.cod := valorAlto;
end;

procedure obtenerMaximo(var maxV: venta; v:venta );
begin
	if(maxV < v)then
		maxV := v;
end;
procedure minimo(arrD:arch; arrRV; var min:venta);
var
	v:venta;
	i,codMin,pos,fechaMin:integer;
begin
	pos:= valorAlto;
	codMin := valorAlto;
	fechaMin:= valorAlto;
	for(i:=1 to 30) do begin
		if(arrRV[i].cod < codMin and arrRV[i].fecha < fechaMin) then begin
			pos:= i;
			codMin := arrRV[i].cod;
			fechaMin:= arrRV[i].fecha;
		end;
	end;
	min:= arrRV[pos];
	if(pos <> valorAlto)
	leerArchivo(arrD[pos],arrRV[pos]);
end;
var
	i,total,cod:integer;
	min,maxV,v:venta;
	at:text;
	arrRV:arrRV;
	arrD: arr_ArchReg;
BEGIN

	for(i := 1 to 30 )do begin
		assign(arrD[i], ('Archivo',i,'.txt'));
		reset(arrD[i]);
		leerArchivo(arrD[i],arrReg[i]);
	end;
	
	assign(at,'maestroTexto.txt');
	rewrite(at);	
	// Obtengo el minimo
	minimo(arrD,arrReg,min);
	// Mientras no haya terminado todos los archivos
	while(min <> valorAlto)do begin
		total:= 0;	// Setteo total
		cod := min.cod;	// Setteo codigo actual
		v := min	// Setteo venta actual
		// Mientras el codigo minimo sea igual al codigo actual
		while(min.cod = cod)do begin
			fecha := min.fecha; // Setteo fecha actual
			// Mientras el codigo minimo sea igual al codigo actual y la fecha minima sea igual a la fecha actual
			while(min.cod = cod and min.fecha = fecha)do begin
				total:= total + min.cantVend; // Sumo las ventas
				minimo(arrD,arrReg,min);  // Tomo otro minimo
			end;
			v.cantVend := total;
			writeln(at,v.cod);
			writeln(at,v.nombre);
			writeln(at,'fecha: ',v.fecha,' total: ',total); // Guardo los datos en el archivo text
			obtenerMaximo(maxV,v); // Voy comparando para obtener el farmaco con mas ventas
		end;
	end;
	writeln('El farmaco mas vendido fue: ', maxV.nombre ,' con ',maxV.cantVend,' ventas');
	close(at)
END.
