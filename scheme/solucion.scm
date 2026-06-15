#lang racket

;; ========================================================
;; FUNCION: obtener-tiempo
;; NATURALEZA: Pura
;; ESTRATEGIA: Busqueda en lista de asociacion
;; IMPACTO: No destructiva
;; ========================================================

(define (obtener-tiempo config color)
  (cdr (assoc color config)))

;; ========================================================
;; FUNCION: transicion
;; NATURALEZA: Pura
;; ESTRATEGIA: Condicional
;; IMPACTO: No destructiva
;; ========================================================

(define (transicion color-actual cambiar)
  (cond
    ((eq? cambiar 'rojo)
     (list color-actual 'cambiar_a_rojo))
    ((eq? cambiar 'amarillo)
     (list color-actual 'cambiar_a_amarillo))
    ((eq? cambiar 'verde)
     (list color-actual 'cambiar_a_verde))
    (else
     (list color-actual 'accion-por-defecto))))

;; ========================================================
;; FUNCION: semaforo-en
;; NATURALEZA: Pura
;; ESTRATEGIA: Uso de modulo sobre duracion dinamica
;; IMPACTO: No destructiva
;; ========================================================
;; NOTA:
;; Esta funcion cumple el rol de TIMER del enunciado original.
;; Se utiliza el nombre semaforo-en para mantener consistencia
;; con la implementacion Common Lisp del proyecto.

(define (semaforo-en timestamp config)
  (let* ((time-rojo (obtener-tiempo config 'rojo))
         (time-verde (obtener-tiempo config 'verde))
         (time-amarillo (obtener-tiempo config 'amarillo))
         (total (+ time-rojo time-verde time-amarillo))
         (ciclo (modulo timestamp total)))
    (cond
      ((< ciclo time-rojo) 'rojo)
      ((< ciclo (+ time-rojo time-verde)) 'verde)
      (else 'amarillo))))

;; ========================================================
;; PRUEBAS SUGERIDAS
;; ========================================================

;;(define config
;;  '((rojo . 90)
;;    (verde . 120)
;;    (amarillo . 6)))
;; (transicion 'en-rojo 'verde)
;; Resultado esperado: '(en-rojo cambiar_a_verde)

;; (transicion 'en-rojo 'azul)
;; Resultado esperado: '(en-rojo accion-por-defecto)

;; (semaforo-en 0 config)
;; Resultado esperado: 'rojo

;; (semaforo-en 90 config)
;; Resultado esperado: 'verde

;; (semaforo-en 210 config)
;; Resultado esperado: 'amarillo

;; (semaforo-en 216 config)
;; Resultado esperado: 'rojo
