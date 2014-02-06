def recopilar_informacion(conn,guardar_en) #Obtiene los datos para las consultas y repeticiones
  con_temp = Sequel.connect(conn)
  con_temp['select id_consulta,sql_query,repeticiones from consulta'].each do |row|
    guardar_en[row[:id_consulta]] = {:sql_query => row[:sql_query], :repeticiones => row[:repeticiones].to_i}
  end
end

def prender(servidor) #Inicia el proceso del servidor
  Process.spawn(servidor[:inicio])
  sleep 5
end

def apagar(servidor) #Termina el proceso del servidor
  Process.spawn(servidor[:apagado])
  sleep 5
end

def iniciar_conexion(servidor,lista_servidores)      #Inicia una conexion
  if (servidor[:conn_string] == lista_servidores[:sqlserver][:conn_string]) then return Sequel.odbc(servidor[:conn_string]) end
  return Sequel.connect(servidor[:conn_string])
end

def realizar_query(conn,info) #Realiza un query a la conexion y retorna el tiempo que tarda
  tiempo = Time.now().to_f
  i = 0
  conn.fetch(info[:sql_query]) do |fila|
    tiempo = Time.now().to_f - tiempo unless i>0
    i+=1
    p fila
  end

  return tiempo
end

def vaciar_tiempos(fuente)
  con_temp = Sequel.connect(fuente)
  ds = con_temp[:tiempo]
  ds.delete
end

def leer_tiempos(fuente,cant_consultas=3)
  con = Sequel.connect(fuente)
  i = 1;

  tabla_tiempo = con.fetch('SELECT * FROM tiempo') do |fila|
    p "El motor #{i} se tardo:"
    for j in 1..cant_consultas do
      p "" + fila[:"#{j}"].to_s + " segundos en la consulta #{j}"
    end
    i += 1
  end


end

def almacenar_tiempos(servidores)
  servidores.each do |index_servidor,info_servidor|
    tiempos_temp = info_servidor[:tiempos]
    con = Sequel.connect(fuente)
    ds = con[:tiempo]
    ds.insert(1=>tiempos_temp[1],2=>tiempos_temp[2],3=>tiempos_temp[3])
  end
end