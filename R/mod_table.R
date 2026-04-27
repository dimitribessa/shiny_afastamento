#' table UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList renderTable tableOutput
#' @importFrom reactable reactable reactableOutput renderReactable
#' @importFrom dplyr left_join
#' 
mod_table_ui <- function(id) {
  ns <- NS(id)
  tagList(
    nowui_card(title = 'Partes do corpo atingida',
    reactableOutput(ns('tabela')))
 
  )
}
    
#' table Server Functions
#'
#' @noRd 
mod_table_server <- function(id, data){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    data_ <- data
    output$tabela <- renderReactable({
      data_ <- data_()
      data_ <- with(data_, as.data.frame(table(cod_partes), stringsAsFactors = F))
      data_[,1] <- as.numeric(data_[,1])
      data_ <- left_join(data_, corpo, by = c('cod_partes' = 'codigo'))
      names(data_)[3:2] <- c('Parte do corpo', 'Quantidade')
      data_ <- data_[,c(3,2)]
      reactable(data_ , pagination = F, height = '400px')
    })

  })
}
    
## To be copied in the UI
# mod_table_ui("table_1")
    
## To be copied in the server
# mod_table_server("table_1")
