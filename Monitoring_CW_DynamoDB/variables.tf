variable "alarm_name" {
  description = "nombre de la alarma"
  type        = string
}

variable "comparison_operator" {
  description = "Operador de comparación (e.g. GreaterThanThreshold)"
  type        = string
}

variable "evaluation_periods" {
  description = "periodo de evaluacion"
  type        = number
}

variable "metric_name" {
  description = "nombre de la metrica"
  type        = string
}

variable "namespace" {
  description = "nombre_recurso"
  type        = string
}

variable "period" {
  description = "periodo de validacion"
  type        = number
}

variable "statistic" {
  type = string
}

variable "threshold" {
  description = "umbral"
  type        = number
}

variable "alarm_description" {
  description = "descripcion de la alarma"
  type        = string
}

variable "alarm_actions" {
  description = "accion de la alarma"
  type        = list(string)
}

variable "dimensions" {
  description = "Dimensiones como TableName, etc."
  type        = map(string)
}
