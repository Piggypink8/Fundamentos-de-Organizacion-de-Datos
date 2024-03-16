program Ejercicio6Practica1;
type
	celular = record
		cod: integer;
		nombre:String[12];
		marca:String[12];
		desc:String[30];
		stockDisp:integer;
		precio:integer;
		stockMin:integer;
		end;
	archivoText = text;
	archivo = file of celular;
	
procedure mostrarMenu(var opcion:integer);
begin
	writeln('0: Crear archivo');
	writeln('1: Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock minimo');
	writeln('2: Listar en pantalla los celulares del archivo cuya descripcion contenga una cadena de caracteres proporcionada por el usuario.');
	writeln('3: Exportar el archivo creado a un archivo de texto denominado “celulares.txt” con todos los celulares del mismo.');
	writeln('4: Cerrar menu');
	readln(opcion);
end;
procedure leerCelular(var c:celular);
begin
	writeln('Ingrese codigo');
	readln(c.cod);
	if(c.cod <> 0)then begin
	writeln('Ingrese precio');
	readln(c.precio);
	writeln('Ingrese nombre');
	readln(c.nombre);
	writeln('Ingrese marca');
	readln(c.marca);
	writeln('Ingrese una descripcion');
	readln(c.desc);
	writeln('Ingrese stock disponible');
	readln(c.stockDisp);
	writeln('Ingrese stock minimo');
	readln(c.stockMin);
	end;
end;
procedure opcionA(var arch:archivo);
var
	c:celular;
begin
	reset(arch);
	leerCelular(c);
	while(c.cod <> 0)do begin
		write(arch, c);
		leerCelular(c);
	end;
	close(arch);
end;
procedure opcionB(var arch:archivo);
var
	c:celular;
begin
	reset(arch);
	while(not eof(arch)) do begin
		read(arch,c);
		if(c.stockDisp < c.stockMin) then begin
			writeln(c.nombre, ' codigo: ', c.cod, ' quedan: ',c.stockDisp);
			writeln('-------------------');
		end;
	end;
end;
procedure opcionC(var arch:archivo);
var
	encontre: boolean;
	c:celular;
	descripcion:String[30];
begin
	encontre := false;
	writeln('Ingrese una descripcion');
	readln(descripcion);
	reset(arch);
	while(not eof(arch) and not encontre) do begin
		read(arch,c);
		if(c.desc = descripcion)then begin
			encontre := true;
			writeln('Codigo: ', c.cod,' Nombre: ', c.nombre,' Descripcion: ', c.desc,' Precio: ', c.precio);
			writeln('-------------------');
		end;
	end;
end;
procedure opcionD(var arch: archivo; var arch2:archivoText);
var
	c:celular;
begin
	assign(arch2,'celulares.txt');
	rewrite(arch2);
	reset(arch);
	while(not eof(arch))do begin
		read(arch, c);
		writeln(arch2,  c.cod,' ', c.nombre,' ', c.stockMin ,' ', c.stockDisp, ' ',c.precio);
		writeln(arch2, c.desc);
		writeln(arch2, c.marca);
	end;
	close(arch);
	close(arch2);
end;
procedure opcionE(var arch:archivo);
var
	c:celular;
begin
	reset(arch);
	seek(arch,filesize(arch));
	leerCelular(c);
	while(c.cod <> 0)do begin
		write(arch, c);
		leerCelular(c);
	end;
	close(arch);
end;
procedure opcionF(var arch:archivo);
var
	c:celular;
	stock:integer;
	nombre:string[12];
begin
	writeln('Ingrese nombre de celular');
	readln(nombre);
	writeln('Ingrese stock');
	readln(stock);
	reset(arch);
	while(not eof(arch))do begin
		read(arch, c);
		if(c.nombre = nombre)then 
			c.stockDisp := stock;
		writeln('Ingrese nombre de celular');
		readln(nombre);
		writeln('Ingrese stock');
		readln(stock);
	end;
end;
procedure opcionG(var arch:archivo;var arch3:archivoText);
var
	c:celular;
begin
	assign(arch3,'SinStock.txt');
	rewrite(arch3);
	reset(arch);
	while(not eof(arch))do begin
		read(arch, c);
		if(c.stockDisp = 0)then begin
			writeln(arch3,  c.cod,' ', c.nombre,' ', c.stockMin ,' ', c.stockDisp, ' ',c.precio);
			writeln(arch3, c.desc);
			writeln(arch3, c.marca);
		end;
	end;
	close(arch);
	close(arch3);
end;
var
	nombre:String[20];
	arch: archivo;
	arch3:archivoText;
	arch2: archivoText;
	opcion:integer;
begin
	mostrarMenu(opcion);
	while(opcion <> 4)do begin
		if(opcion = 0)then begin
			writeln('Ingrese nombre archivo');
			readln(nombre);
			assign(arch, nombre);
			rewrite(arch);
			opcionA(arch);
		end
		else begin
			if(opcion = 1)then
				opcionB(arch)
			else
				if (opcion = 2)then
					opcionC(arch)
				else
					if(opcion = 3) then
						opcionD(arch,arch2)
					else
						if(opcion = 4)then
							opcionF(arch)
						else
							if(opcion = 5)then 
								opcionE(arch)
							else
								opcionG(arch,arch3)
			end;
		mostrarMenu(opcion);
		
	end;
END.
