;==============================================================
;; FUNCION: mostrarCambio
;; NATURALEZA: Impura
;; ESTRATEGIA: Salida por pantalla + uso de librería local-time
;; IMPACTO: No destructiva
;==============================================================

(ql:quickload "local-time")

(defun mostrarCambio (tiempo colorAnt colorNue)
  (format t
          "[~A] La luz ha cambiado de ~A a ~A~%"
          (local-time:format-timestring
             nil
             (local-time:unix-to-timestamp tiempo))
          colorAnt
          colorNue)
)