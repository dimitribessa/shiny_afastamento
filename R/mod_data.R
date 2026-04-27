#' data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList selectInput reactive bindEvent eventReactive
#' @importFrom dplyr left_join
#' @import magrittr
#' 
#' @export

mod_data_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    #tags$div(class = 'collapse navbar-collapse justify-content-end',
    selectInput(ns('ano'), 'Ano', choices = unique(data_cat$ano), selected = unique(data_cat$ano), multiple = T, width = '80%'),
    selectInput(ns('tipo'), 'Tipo de acidente', choices = c('Todos','Típico', 'Trajeto', 'Doença'), selected = 'Todos', width = '80%'),
    selectInput(ns('risco'), 'Fator de Risco (Grupo)', choices = c('Todos',unique(risco$grupo_risco)), selected = 'Todos', width = '80%'),
    selectInput(ns('cnae'), 'Seção CNAE', choices = c('Todas',cnae_secao[,2]), selected = 'Todas', width = '80%'),
    
    shiny::actionButton(ns('atualizar'),'Atualizar')
  #)
  )
}
    
#' data Server Functions
#'
#' @noRd 
mod_data_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    data_ <- reactiveVal()

    observe({
      dadoi <- data_cat[which(data_cat$ano %in% as.numeric(input$ano)),]
      if(input$tipo != 'Todos'){
        dadoi <- dadoi[which(dadoi$tipo.do.acidente == input$tipo), ]
      }
      if(input$risco != 'Todos'){
        risco <- risco[risco$grupo_risco == input$risco,]
        dadoi <- dadoi[which(dadoi$cod_risco %in% risco$cod_risco), ]
      }
      if(input$cnae != 'Todas'){
        cnae <- cnae_secao[which(cnae_secao$denominação == input$cnae), ]
        dadoi <- dadoi[which(dadoi$seção %in% cnae$seção), ]
      }
      
      if(nrow(dadoi) == 0){
                      return(
                      showModal(modalDialog(
                      title = NULL,
                      tagList(
                      p("Não há registros")),
                      easyClose = TRUE,
                      footer = NULL
                      )))
                   }else{
                   
                    data_(dadoi)
                   }
    }) %>% bindEvent(input$atualizar, ignoreNULL = F)
   data_
  })
}
    
## To be copied in the UI
# mod_data_ui("data_1")
    
## To be copied in the server
# mod_data_server("data_1")
