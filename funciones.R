navegar <- function(url) {
  rsc$navigate(url)
}

buscarCedula <- function(cedula) {
  campoCedula <- rsc$findElement('id', 'txtcedula')
  campoCedula$sendKeysToElement(list(cedula, key = 'enter'))
}

consultando <- function() {
  cargando <- T
  while (cargando) {
    lblConsultando <- rsc$findElements('xpath', '//p[contains(text(), "Consulta realizándose")]')
    
    if (length(lblConsultando) == 0) {
      cargando <- F
      cat('\r Consulta terminada')
    } else{
      cat('\r Consultando.')
      Sys.sleep(0.1)
      cat('\r Consultando..')
      Sys.sleep(0.1)
      cat('\r Consultando...')
    }
    
  }
}

verMasDetalle <- function() {
  botonVerMasDetalle <- rsc$findElements('xpath', '//a[@title="Ver más detalles del nacimiento"]')
  botonVerMasDetalle[[1]]$clickElement()
}

regresarConsultaAnterior <- function() {
  botonRegresarALaConsultaAnterior <- rsc$findElements('xpath',
                                                       '//a[contains(text(), "Regresar a la consulta anterior")]')
  botonRegresarALaConsultaAnterior[[1]]$clickElement()
}

informacion <- function() {
  datos <- list()
  campos <- c(
    'lblcedula',
    'lblnombre',
    'lblprimer_apellido',
    'lblsegundo_apellido',
    'lblfecha_nacimiento',
    'lbllugar_nacimiento',
    'lblnacionalidad',
    'lblnombre_padre',
    'lblid_padre',
    'lblnombre_madre',
    'lblid_madre',
    'lblempadronado',
    'lblfallecido'
  )
  
  for (campo in campos) {
    elemento <- rsc$findElement('id', campo)
    datos[[campo]] <- elemento$getElementText()[[1]]
  }
  
  return(datos)
}

hijosRegistrados <- function() {
  botonMostrar <- rsc$findElement('id', 'btnMostrarNacimiento')
  botonMostrar$clickElement()
}

informacionHijos <- function() {
  tabla <- NULL
  panel <- rsc$findElements('id', 'UpdatePanel1')
  
  if (length(panel[[1]]$findChildElements('id', 'Gridhijos')) > 0) {
    tabla <- panel[[1]]$getElementAttribute('outerHTML') %>% unlist() %>% read_html() %>% html_table(convert = FALSE) %>% .[[1]]
    tabla <- tabla[, 2:4]
  } else{
    sinHijos <- panel[[1]]$findChildElements('id', 'lblHijos')
    if (length(sinHijos) > 0) {
      tabla <- list(
        'CEDULA' = character(),
        'FECHA NACIMIENTO' = character(),
        'NOMBRE' = character()
      )
    }
  }
  
  
  return(tabla)
}

matrimoniosRegistrados <- function() {
  botonMostrar <- rsc$findElement('id', 'btnMostrarMatrimonios')
  botonMostrar$clickElement()
}

informacionMatrimonio <- function() {
  datos <- NULL
  
  panel <- rsc$findElements('id', 'UpdatePanel2')
  
  if (length(panel[[1]]$findChildElements('id', 'Gridmatrimonios')) > 0) {
    datos <- list()
    tabla <- panel[[1]]$findChildElements('xpath', './/a[contains(text(),"Detalle")]')
    tabla[[length(tabla)]]$clickElement()
    Sys.sleep(0.5)
    
    verificacionExtranjero <- rsc$findElements('id', 'lblextrangero')
    
    if (length(verificacionExtranjero) > 1) {
      #dado caso que se encuentre el campo, no es extranjero
      campos <- c(
        'lblcita',
        'lblcedula_conyugue',
        'lblnombre_conyugue',
        'lbllugar_suceso',
        'lblfecha_suceso',
        'lbltipo_relacion',
        'lblextrangero',
        'lblfallecido'
      )
      
      
    } else{
      
      campos <- c(
        'lblcita',
        'lblnombreconyugue',
        'lblfechasuceso',
        'lbltiporelacion',
        'lblpadreconyugue',
        'lblmadreconyugue'
      )
      
      
    }
    
    for (campo in campos) {
      elemento <- rsc$findElement('id', campo)
      datos[[campo]] <- elemento$getElementText()[[1]]
      
    }
    
  } else{
    sinMatrimonios <- panel[[1]]$findChildElements('id', 'lblMatrimonios')
    if (length(sinMatrimonios) > 0) {
      datos <- list(
        'lblcita'            = character(),
        'lblcedula_conyugue' = character(),
        'lblnombre_conyugue' = character(),
        'lbllugar_suceso'    = character(),
        'lblfecha_suceso'    = character(),
        'lbltipo_relacion'   = character(),
        'lblextrangero'      = character(),
        'lblfallecido'       = character()
      )
    }
  }
  
  return(datos)
}

lugarDeVotacion <- function() {
  botonMostrar <- rsc$findElements('id', 'btnMostrarVotacion')
  botonMostrar[[1]]$clickElement()
}

informacionLugarDeVotacion <- function() {
  tabla <- NULL
  panel <- rsc$findElements('id', 'UpdatePanel3')
  
  if (length(panel[[1]]$findChildElements('id', 'Gridvotacion')) > 0) {
    tabla <- panel[[1]]$getElementAttribute('outerHTML') %>% unlist() %>% read_html() %>% html_table(convert = FALSE) %>% .[[1]]
    tabla <- tabla[, 2:5]
  }
  
  
  return(tabla)
}