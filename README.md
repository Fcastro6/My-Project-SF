# Salesforce Prueba S4G

Hemos planteado un supuesto en el que nuestro sistema salesforce recibe datos de un sistema externo para actualizar registros de Account y Contact.

Se necesitarán validaciones para ciertos datos:
    Account: -CIF: Formato 8 números y empieza por una letra
             -IBAN: Formato 22 números y empieza por ES
    Contact: -Móvil: Formato 9 números y puede empezar por 6 o 7.


## Plan de Solución

-Creación de un objeto custom con la información que se actualizará (ExternalID Account, External ID Contact, CIF, IBAN, Movil) Con sus respectivas validaciones.(Completo)
-Creación de un batch schedulable que se ejecute cada X tiempo, compruebe si hay datos que modificar almacenados en el objeto custom anterior.(Completo)
-Creación de un Custom Apex WS para recibir los datos del sistema externo.(Completo)
-Configuración de la APP POSTMAN para simular el envío de datos de un sistema externo a salesforce.(Completo)
