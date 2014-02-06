#Reemplaza los directorios por las respectivas instalaciones
#Agrega o elimina servidores, o modifica la fuente

$servidores =
    {

        :sqlserver => {
            :conn_string => {:database => 'SqlExpress', :user => "root", :password => "kasikes" },
            :inicio => "NET START MSSQL$SQLEXPRESS",
            :apagado => "NET STOP MSSQL$SQLEXPRESS",
            :tiempos => {

            }

        },
        :mysql => {
            :conn_string => {:adapter=>'mysql', :host=>'127.0.0.1', :database=>'licom', :user=>'root'},
            :inicio => "C:\\mysql\\bin\\mysqld",
            :apagado => '"C:\\mysql\\bin\\mysqladmin" -u root shutdown',
            :tiempos => {

            }
        },
        :postgres => {
            :conn_string => 'postgres://admin:kasikes@localhost:5432/licom',
            :inicio => '"C:\\Archivos de Programa\\PostgreSQL\\9.3\\bin\\postgres" -D "C:\\Archivos de Programa\\PostgreSQL\\9.3\\data"',
            :apagado => '"C:\\Archivos de Programa\\PostgreSQL\\9.3\\bin\\pg_ctl" stop -D "C:\\Archivos de Programa\\PostgreSQL\\9.3\\data" -m fast',
            :tiempos => {

            }
        }
    }

$fuente =
    {
        :adapter=>'ado',
        :conn_string=>'Provider=Microsoft.ACE.OLEDB.12.0;' +
            'Data Source=C:\\Users\\Jose Solorzano\Documents\\AABBDD.accdb'
    }