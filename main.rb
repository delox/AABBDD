  #Este es el archivo principal, el que se debe compilar

  require 'win32/process' # Version actual SOLO funciona en windows
  require 'sequel'
  require Dir.getwd + '/configurame.rb' # hashes de servidores y fuentes
  require Dir.getwd + '/funciones.rb'   # funciones prender,query,apagar,almacenar y leer tiempos, popular variables con informacion de una fuente



  $consultas = Hash.new("Registro vacio.")  #Instancia de hash global consultas
  vaciar_tiempos($fuente)                            #Vaciar tabla Tiempos
  recopilar_informacion($fuente,$consultas) # Populo $consultas desde access

  $servidores.each do |index_servidor,info_servidor| #Itero cada servidor que quiero que participe en la comparacion

    $consultas.each do |indice,info_consulta|

      tiempo = 0 #promedio de tiempo, inicializacion

      for i in 1..info_consulta[:repeticiones]

         p "Iniciando #{index_servidor}..."
         prender(info_servidor) # prender
         conexion = iniciar_conexion(info_servidor,$servidores) #Este paso esta mal disenado, luego lo arreglo, es para comparar con el hash de servers y no tener que acceder a la global desde el metodo

         p "Realizando consulta..."
         tiempo += realizar_query(conexion,info_consulta) #realizar_query retorna el tiempo que se tardo, aunque imprime el resultado sin devolverlo en el metodo
         p tiempo

         p "Apagando #{index_servidor}..."
         apagar(info_servidor)

      end

      info_servidor[:tiempos][indice] = tiempo / info_consulta[:repeticiones]

    end

  end

  almacenar_tiempos($servidores,$fuente)
  leer_tiempos($fuente)

