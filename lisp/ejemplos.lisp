;;==============================================================
;; ARCHIVO: ejemplos.lisp
;; Requerimiento 7: Aseguramiento de la Calidad
;;
;; Cada requerimiento cuenta con:
;;   - Ejemplos de funcionamiento normal
;;   - Ejemplos de caminos alternativos (si los hubiere)
;;   - Ejemplos que generan errores
;;
;; INSTRUCCIONES: Cargar primero core.lisp en CLISP
;;   (load "core.lisp")
;; Luego cargar la configuracion y ejecutar los ejemplos:
;;   (load "ejemplos.lisp")
;;==============================================================

;; ---- Carga de la configuracion desde el archivo JSON --------
(defvar config (cargar-config "config.json"))

(format t "~%=============================================~%")
(format t "  EJEMPLOS DE USO - SISTEMA DE SEMAFOROS~%")
(format t "  Configuracion cargada: ~A~%" config)
(format t "=============================================~%")


;;==============================================================
;; REQUERIMIENTO 1: transicion
;; Funcion: (transicion color-actual cambiar-a)
;; Ciclo: rojo -> rojo-intermitente -> verde ->
;;        verde-intermitente -> amarillo ->
;;        amarillo-intermitente -> rojo
;;==============================================================

(format t "~%--- REQUERIMIENTO 1: transicion ---~%~%")

;; --- Funcionamiento normal ---
;; Transicion de rojo a rojo-intermitente
(format t "Ejemplo 1.1 - Normal: (transicion 'rojo 'rojo-intermitente)~%")
(format t "  Resultado: ~A~%" (transicion 'rojo 'rojo-intermitente))
;; Esperado: (ROJO "cambiar-a-rojo-intermitente")

;; Transicion de rojo-intermitente a verde
(format t "Ejemplo 1.2 - Normal: (transicion 'rojo-intermitente 'verde)~%")
(format t "  Resultado: ~A~%" (transicion 'rojo-intermitente 'verde))
;; Esperado: (ROJO-INTERMITENTE "cambiar-a-verde")

;; Transicion de verde a verde-intermitente
(format t "Ejemplo 1.3 - Normal: (transicion 'verde 'verde-intermitente)~%")
(format t "  Resultado: ~A~%" (transicion 'verde 'verde-intermitente))
;; Esperado: (VERDE "cambiar-a-verde-intermitente")

;; Transicion de verde-intermitente a amarillo
(format t "Ejemplo 1.4 - Normal: (transicion 'verde-intermitente 'amarillo)~%")
(format t "  Resultado: ~A~%" (transicion 'verde-intermitente 'amarillo))
;; Esperado: (VERDE-INTERMITENTE "cambiar-a-amarillo")

;; Transicion de amarillo a amarillo-intermitente
(format t "Ejemplo 1.5 - Normal: (transicion 'amarillo 'amarillo-intermitente)~%")
(format t "  Resultado: ~A~%" (transicion 'amarillo 'amarillo-intermitente))
;; Esperado: (AMARILLO "cambiar-a-amarillo-intermitente")

;; Transicion de amarillo-intermitente a rojo
(format t "Ejemplo 1.6 - Normal: (transicion 'amarillo-intermitente 'rojo)~%")
(format t "  Resultado: ~A~%" (transicion 'amarillo-intermitente 'rojo))
;; Esperado: (AMARILLO-INTERMITENTE "cambiar-a-rojo")

;; --- Caminos alternativos ---
;; Transicion con color destino invalido -> accion-por-defecto
(format t "Ejemplo 1.7 - Alternativo: (transicion 'rojo 'azul)~%")
(format t "  Resultado: ~A~%" (transicion 'rojo 'azul))
;; Esperado: (ROJO ACCION-POR-DEFECTO)

;; Estado actual no reconocido
(format t "Ejemplo 1.8 - Alternativo: (transicion 'apagado 'rojo)~%")
(format t "  Resultado: ~A~%" (transicion 'apagado 'rojo))
;; Esperado: (APAGADO ACCION-POR-DEFECTO)

;; --- Casos de error ---
;; Sin argumentos: genera error por falta de parametros
(format t "Ejemplo 1.9 - Error: (transicion) -> sin argumentos~%")
(format t "  Al ejecutar (transicion) se genera:~%")
(format t "  ERROR: invalid number of arguments: 0~%~%")


;;==============================================================
;; REQUERIMIENTO 2: timer (timer)
;; Funcion: (timer timestamp config)
;; Ciclo con config por defecto:
;;   Rojo=90s, Rojo-Int=3s, Verde=120s,
;;   Verde-Int=3s, Amarillo=6s, Amarillo-Int=3s
;; Total ciclo = 225s
;; Rango rojo:                0 a  89
;; Rango rojo-intermitente:  90 a  92
;; Rango verde:              93 a 212
;; Rango verde-intermitente: 213 a 215
;; Rango amarillo:           216 a 221
;; Rango amarillo-int:       222 a 224
;;==============================================================

(format t "~%--- REQUERIMIENTO 2: timer (timer) ---~%~%")

;; --- Funcionamiento normal ---
;; Timestamp 0 -> inicio del ciclo -> rojo
(format t "Ejemplo 2.1 - Normal: (timer 0 config)~%")
(format t "  Resultado: ~A~%" (timer 0 config))
;; Esperado: ROJO

;; Timestamp 45 -> mitad del rojo
(format t "Ejemplo 2.2 - Normal: (timer 45 config)~%")
(format t "  Resultado: ~A~%" (timer 45 config))
;; Esperado: ROJO

;; Timestamp 90 -> comienza rojo-intermitente
(format t "Ejemplo 2.3 - Normal: (timer 90 config)~%")
(format t "  Resultado: ~A~%" (timer 90 config))
;; Esperado: ROJO-INTERMITENTE

;; Timestamp 93 -> comienza verde
(format t "Ejemplo 2.4 - Normal: (timer 93 config)~%")
(format t "  Resultado: ~A~%" (timer 93 config))
;; Esperado: VERDE

;; Timestamp 150 -> mitad del verde
(format t "Ejemplo 2.5 - Normal: (timer 150 config)~%")
(format t "  Resultado: ~A~%" (timer 150 config))
;; Esperado: VERDE

;; Timestamp 213 -> comienza verde-intermitente
(format t "Ejemplo 2.6 - Normal: (timer 213 config)~%")
(format t "  Resultado: ~A~%" (timer 213 config))
;; Esperado: VERDE-INTERMITENTE

;; Timestamp 216 -> comienza amarillo
(format t "Ejemplo 2.7 - Normal: (timer 216 config)~%")
(format t "  Resultado: ~A~%" (timer 216 config))
;; Esperado: AMARILLO

;; Timestamp 222 -> comienza amarillo-intermitente
(format t "Ejemplo 2.8 - Normal: (timer 222 config)~%")
(format t "  Resultado: ~A~%" (timer 222 config))
;; Esperado: AMARILLO-INTERMITENTE

;; --- Caminos alternativos ---
;; Timestamp 225 -> nuevo ciclo, vuelve a rojo (225 mod 225 = 0)
(format t "Ejemplo 2.9 - Alternativo: (timer 225 config)~%")
(format t "  Resultado: ~A~%" (timer 225 config))
;; Esperado: ROJO (nuevo ciclo)

;; Timestamp grande (1000000) -> funciona con mod
(format t "Ejemplo 2.10 - Alternativo: (timer 1000000 config)~%")
(format t "  Resultado: ~A~%" (timer 1000000 config))
;; 1000000 mod 225 = 100 -> VERDE

;; Timestamp 89 -> ultimo segundo de rojo
(format t "Ejemplo 2.11 - Alternativo: (timer 89 config)~%")
(format t "  Resultado: ~A~%" (timer 89 config))
;; Esperado: ROJO (limite del rango)

;; Timestamp 224 -> ultimo segundo de amarillo-intermitente
(format t "Ejemplo 2.12 - Alternativo: (timer 224 config)~%")
(format t "  Resultado: ~A~%" (timer 224 config))
;; Esperado: AMARILLO-INTERMITENTE (ultimo segundo antes de reiniciar)

;; --- Casos de error ---
;; Timestamp negativo: mod con negativos produce resultado
;; dependiente de la implementacion
(format t "Ejemplo 2.13 - Error: (timer -1 config)~%")
(format t "  Resultado: ~A~%" (timer -1 config))
;; Resultado depende del comportamiento de MOD con negativos

;; Sin config: genera error de tipo
(format t "Ejemplo 2.14 - Error: (timer 100 nil) -> config vacia~%")
(format t "  Al ejecutar (timer 100 nil) se genera:~%")
(format t "  ERROR: The value NIL is not of type NUMBER~%~%")


;;==============================================================
;; REQUERIMIENTO 3: mostrar-cambio (auditoria)
;; Funcion: (mostrar-cambio tiempo colorAnterior colorNuevo)
;;==============================================================

(format t "~%--- REQUERIMIENTO 3: mostrar-cambio (auditoria) ---~%~%")

;; --- Funcionamiento normal ---
(format t "Ejemplo 3.1 - Normal: (mostrar-cambio 90 'rojo 'rojo-intermitente)~%")
(format t "  Resultado: ")
(mostrar-cambio 90 'rojo 'rojo-intermitente)
;; Esperado: Tiempo 90: la luz ha cambiado de ROJO a ROJO-INTERMITENTE

(format t "Ejemplo 3.2 - Normal: (mostrar-cambio 93 'rojo-intermitente 'verde)~%")
(format t "  Resultado: ")
(mostrar-cambio 93 'rojo-intermitente 'verde)
;; Esperado: Tiempo 93: la luz ha cambiado de ROJO-INTERMITENTE a VERDE

(format t "Ejemplo 3.3 - Normal: (mostrar-cambio 216 'verde-intermitente 'amarillo)~%")
(format t "  Resultado: ")
(mostrar-cambio 216 'verde-intermitente 'amarillo)
;; Esperado: Tiempo 216: la luz ha cambiado de VERDE-INTERMITENTE a AMARILLO

;; --- Caminos alternativos ---
;; Uso combinado con timer para registrar un cambio real
(format t "Ejemplo 3.4 - Alternativo: Combinar con timer~%")
(let ((color-en-89 (timer 89 config))
      (color-en-90 (timer 90 config)))
  (format t "  Color en t=89: ~A | Color en t=90: ~A~%" color-en-89 color-en-90)
  (format t "  Registro: ")
  (mostrar-cambio 90 color-en-89 color-en-90))
;; Muestra el cambio detectado en el limite rojo->rojo-intermitente

;; --- Casos de error ---
;; Sin argumentos: genera error por falta de parametros
(format t "Ejemplo 3.5 - Error: (mostrar-cambio) -> sin argumentos~%")
(format t "  Al ejecutar (mostrar-cambio) se genera:~%")
(format t "  ERROR: invalid number of arguments: 0~%~%")


;;==============================================================
;; REQUERIMIENTO 4a: duracion-ciclo
;; Funcion: (duracion-ciclo config)
;;==============================================================

(format t "~%--- REQUERIMIENTO 4a: duracion-ciclo ---~%~%")

;; --- Funcionamiento normal ---
;; Con la config por defecto: 90+3+6+3+120+3 = 225
(format t "Ejemplo 4a.1 - Normal: (duracion-ciclo config)~%")
(format t "  Resultado: ~A segundos~%" (duracion-ciclo config))
;; Esperado: 225

;; --- Caminos alternativos ---
;; Con una configuracion personalizada (tiempos cortos)
(format t "Ejemplo 4a.2 - Alternativo: Config personalizada corta~%")
(let ((config-corta '((:rojo . 10) (:rojo-intermitente . 2)
                      (:amarillo . 3) (:amarillo-intermitente . 2)
                      (:verde . 15) (:verde-intermitente . 2))))
  (format t "  (duracion-ciclo config-corta) = ~A segundos~%"
          (duracion-ciclo config-corta)))
;; Esperado: 34

;; Con una configuracion de tiempos largos
(format t "Ejemplo 4a.3 - Alternativo: Config personalizada larga~%")
(let ((config-larga '((:rojo . 60) (:rojo-intermitente . 5)
                      (:amarillo . 10) (:amarillo-intermitente . 5)
                      (:verde . 80) (:verde-intermitente . 5))))
  (format t "  (duracion-ciclo config-larga) = ~A segundos~%"
          (duracion-ciclo config-larga)))
;; Esperado: 165

;; --- Casos de error ---
;; Config vacia: genera error de tipo al intentar sumar nil
(format t "Ejemplo 4a.4 - Error: (duracion-ciclo nil) -> config vacia~%")
(format t "  Al ejecutar (duracion-ciclo nil) se genera:~%")
(format t "  ERROR: The value NIL is not of type NUMBER~%~%")


;;==============================================================
;; REQUERIMIENTO 4b: recomendacion-ciclo
;; Funcion: (recomendacion-ciclo duracion)
;; Rango optimo: 35 a 150 segundos
;;==============================================================

(format t "~%--- REQUERIMIENTO 4b: recomendacion-ciclo ---~%~%")

;; --- Funcionamiento normal ---
;; Duracion dentro del rango (config por defecto = 225 -> fuera de rango)
(format t "Ejemplo 4b.1 - Normal: (recomendacion-ciclo (duracion-ciclo config))~%")
(format t "  Duracion actual: ~A~%" (duracion-ciclo config))
(format t "  Resultado: ~A~%" (recomendacion-ciclo (duracion-ciclo config)))
;; Esperado: "Ciclo demasiado largo" (225 > 150)

;; Duracion dentro del rango optimo
(format t "Ejemplo 4b.2 - Normal: (recomendacion-ciclo 100)~%")
(format t "  Resultado: ~A~%" (recomendacion-ciclo 100))
;; Esperado: "Ciclo dentro del rango recomendado"

;; --- Caminos alternativos ---
;; Justo en el limite inferior (35)
(format t "Ejemplo 4b.3 - Alternativo: (recomendacion-ciclo 35)~%")
(format t "  Resultado: ~A~%" (recomendacion-ciclo 35))
;; Esperado: "Ciclo dentro del rango recomendado"

;; Justo en el limite superior (150)
(format t "Ejemplo 4b.4 - Alternativo: (recomendacion-ciclo 150)~%")
(format t "  Resultado: ~A~%" (recomendacion-ciclo 150))
;; Esperado: "Ciclo dentro del rango recomendado"

;; Debajo del limite (demasiado corto)
(format t "Ejemplo 4b.5 - Alternativo: (recomendacion-ciclo 20)~%")
(format t "  Resultado: ~A~%" (recomendacion-ciclo 20))
;; Esperado: "Ciclo demasiado corto"

;; Encima del limite (demasiado largo)
(format t "Ejemplo 4b.6 - Alternativo: (recomendacion-ciclo 200)~%")
(format t "  Resultado: ~A~%" (recomendacion-ciclo 200))
;; Esperado: "Ciclo demasiado largo"

;; --- Casos de error ---
;; Con un string en vez de numero
(format t "Ejemplo 4b.7 - Error: (recomendacion-ciclo \"abc\") -> tipo invalido~%")
(format t "  Al ejecutar (recomendacion-ciclo \"abc\") se genera:~%")
(format t "  ERROR: The value \"abc\" is not of type REAL~%~%")


;;==============================================================
;; REQUERIMIENTO 5: ciclos-por-tiempo
;; Funcion: (ciclos-por-tiempo minutos config)
;; Con config por defecto: ciclo = 225s
;;==============================================================

(format t "~%--- REQUERIMIENTO 5: ciclos-por-tiempo ---~%~%")

;; --- Funcionamiento normal ---
;; 15 minutos = 900 segundos / 225 = 4 ciclos completos
(format t "Ejemplo 5.1 - Normal: (ciclos-por-tiempo 15 config)~%")
(format t "  Resultado: ~A ciclos~%" (ciclos-por-tiempo 15 config))
;; Esperado: 4

;; 60 minutos (1 hora) = 3600 / 225 = 16 ciclos completos
(format t "Ejemplo 5.2 - Normal: (ciclos-por-tiempo 60 config)~%")
(format t "  Resultado: ~A ciclos~%" (ciclos-por-tiempo 60 config))
;; Esperado: 16

;; --- Caminos alternativos ---
;; 1 minuto = 60 / 225 = 0 ciclos completos
(format t "Ejemplo 5.3 - Alternativo: (ciclos-por-tiempo 1 config)~%")
(format t "  Resultado: ~A ciclos~%" (ciclos-por-tiempo 1 config))
;; Esperado: 0 (no alcanza para completar un ciclo)

;; 0 minutos
(format t "Ejemplo 5.4 - Alternativo: (ciclos-por-tiempo 0 config)~%")
(format t "  Resultado: ~A ciclos~%" (ciclos-por-tiempo 0 config))
;; Esperado: 0

;; 480 minutos (8 horas, jornada laboral)
(format t "Ejemplo 5.5 - Alternativo: (ciclos-por-tiempo 480 config)~%")
(format t "  Resultado: ~A ciclos~%" (ciclos-por-tiempo 480 config))
;; Esperado: 128

;; Con config personalizada de ciclo corto (34s)
(format t "Ejemplo 5.6 - Alternativo: Config corta, 15 minutos~%")
(let ((config-corta '((:rojo . 10) (:rojo-intermitente . 2)
                      (:amarillo . 3) (:amarillo-intermitente . 2)
                      (:verde . 15) (:verde-intermitente . 2))))
  (format t "  (ciclos-por-tiempo 15 config-corta) = ~A ciclos~%"
          (ciclos-por-tiempo 15 config-corta)))
;; Esperado: 26 (900 / 34)

;; --- Casos de error ---
;; Config vacia
(format t "Ejemplo 5.7 - Error: (ciclos-por-tiempo 15 nil) -> config vacia~%")
(format t "  Al ejecutar (ciclos-por-tiempo 15 nil) se genera:~%")
(format t "  ERROR: The value NIL is not of type NUMBER~%~%")


;;==============================================================
;; REQUERIMIENTO 6: distribucion-hora
;; Funcion: (distribucion-hora config)
;;==============================================================

(format t "~%--- REQUERIMIENTO 6: distribucion-hora ---~%~%")

;; --- Funcionamiento normal ---
;; Con config por defecto: rojo=90, amarillo=6, verde=120, total=225
;; Rojo:     90/225 * 100 = 40.00%
;; Amarillo:  6/225 * 100 =  2.67%
;; Verde:   120/225 * 100 = 53.33%
(format t "Ejemplo 6.1 - Normal: (distribucion-hora config)~%")
(format t "  Resultado: ~A~%" (distribucion-hora config))
;; Esperado: ((:ROJO 40.0) (:AMARILLO 2.6666667) (:VERDE 53.333332))

;; --- Caminos alternativos ---
;; Config con tiempos iguales
(format t "Ejemplo 6.2 - Alternativo: Config tiempos iguales~%")
(let ((config-igual '((:rojo . 60) (:rojo-intermitente . 10)
                      (:amarillo . 60) (:amarillo-intermitente . 10)
                      (:verde . 60) (:verde-intermitente . 10))))
  (format t "  (distribucion-hora config-igual) = ~A~%"
          (distribucion-hora config-igual)))
;; Esperado: porcentajes iguales para rojo, amarillo y verde

;; Config con un color dominante
(format t "Ejemplo 6.3 - Alternativo: Config verde dominante~%")
(let ((config-verde '((:rojo . 30) (:rojo-intermitente . 3)
                      (:amarillo . 5) (:amarillo-intermitente . 3)
                      (:verde . 180) (:verde-intermitente . 3))))
  (format t "  (distribucion-hora config-verde) = ~A~%"
          (distribucion-hora config-verde)))
;; Esperado: Verde con mayor porcentaje

;; --- Casos de error ---
;; Config vacia
(format t "Ejemplo 6.4 - Error: (distribucion-hora nil) -> config vacia~%")
(format t "  Al ejecutar (distribucion-hora nil) se genera:~%")
(format t "  ERROR: The value NIL is not of type NUMBER~%~%")


;;==============================================================
;; REQUERIMIENTO 8: informe (persistencia de datos)
;; Funcion: (informe datos)
;; Se arma el log de transiciones y se pasa a informe
;;==============================================================

(format t "~%--- REQUERIMIENTO 8: informe ---~%~%")

;; --- Funcionamiento normal ---
;; Armado del log de transiciones de un ciclo completo
(format t "Ejemplo 8.1 - Normal: Generar informe con log de transiciones~%")
(let ((log-transiciones
        (list
          (format nil "Transicion: INICIO -> ~A" (timer 0 config))
          (format nil "Transicion: ~A -> ~A"
                  (timer 89 config) (timer 90 config))
          (format nil "Transicion: ~A -> ~A"
                  (timer 92 config) (timer 93 config))
          (format nil "Transicion: ~A -> ~A"
                  (timer 212 config) (timer 213 config))
          (format nil "Transicion: ~A -> ~A"
                  (timer 215 config) (timer 216 config))
          (format nil "Transicion: ~A -> ~A"
                  (timer 221 config) (timer 222 config))
          (format nil "Transicion: ~A -> ~A"
                  (timer 224 config) (timer 225 config)))))
  (format t "  Log armado: ~A~%" log-transiciones)
  (informe log-transiciones))
;; Esperado: Se genera 'informe-ejecucion-semaforo.txt' con:
;;   Transicion: INICIO -> ROJO
;;   Transicion: ROJO -> ROJO-INTERMITENTE
;;   Transicion: ROJO-INTERMITENTE -> VERDE
;;   Transicion: VERDE -> VERDE-INTERMITENTE
;;   Transicion: VERDE-INTERMITENTE -> AMARILLO
;;   Transicion: AMARILLO -> AMARILLO-INTERMITENTE
;;   Transicion: AMARILLO-INTERMITENTE -> ROJO

;; --- Caminos alternativos ---
;; Lista vacia: genera el archivo solo con encabezado y pie
(format t "Ejemplo 8.2 - Alternativo: (informe nil) -> lista vacia~%")
(informe nil)
;; Esperado: Se genera el archivo solo con encabezado y 'Fin del Informe'

;; Un solo registro
(format t "Ejemplo 8.3 - Alternativo: un solo registro~%")
(informe '("Transicion: ROJO -> ROJO-INTERMITENTE"))
;; Esperado: Se genera el archivo con una sola linea de transicion

;; --- Casos de error ---
;; Sin argumentos: genera error por falta de parametros
(format t "Ejemplo 8.4 - Error: (informe) -> sin argumentos~%")
(format t "  Al ejecutar (informe) se genera:~%")
(format t "  ERROR: invalid number of arguments: 0~%~%")


;;==============================================================
;; EJEMPLO INTEGRADOR: Simulacion de un ciclo completo
;; Combina transicion, timer y mostrar-cambio
;; Ciclo de 6 fases (225 segundos)
;;==============================================================

(format t "~%--- EJEMPLO INTEGRADOR ---~%~%")

(format t "Simulacion de cambios en un ciclo completo (225 segundos):~%~%")

;; Uso de mapcar (funcion de orden superior) para recorrer
;; los timestamps relevantes de cada fase
(mapcar (lambda (t-actual)
          (format t "  t=~3D -> ~A~%" t-actual (timer t-actual config)))
        '(0 89 90 92 93 212 213 215 216 221 222 224 225))

(format t "~%Registro de transiciones detectadas:~%~%")
;; Transiciones explicitas sin bucles ni variables mutables
(mostrar-cambio 0 'inicio (timer 0 config))
(mostrar-cambio 90 (timer 89 config) (timer 90 config))
(mostrar-cambio 93 (timer 92 config) (timer 93 config))
(mostrar-cambio 213 (timer 212 config) (timer 213 config))
(mostrar-cambio 216 (timer 215 config) (timer 216 config))
(mostrar-cambio 222 (timer 221 config) (timer 222 config))
(mostrar-cambio 225 (timer 224 config) (timer 225 config))

(format t "~%Resumen del sistema:~%")
(format t "  Duracion del ciclo: ~A segundos~%" (duracion-ciclo config))
(format t "  Recomendacion: ~A~%" (recomendacion-ciclo (duracion-ciclo config)))
(format t "  Ciclos en 15 min: ~A~%" (ciclos-por-tiempo 15 config))
(format t "  Ciclos en 1 hora: ~A~%" (ciclos-por-tiempo 60 config))
(format t "  Distribucion: ~A~%" (distribucion-hora config))

(format t "~%=============================================~%")
(format t "  FIN DE LOS EJEMPLOS~%")
(format t "=============================================~%")
