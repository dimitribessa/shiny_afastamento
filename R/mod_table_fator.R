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
mod_table_fator_ui <- function(id) {
  ns <- NS(id)
  tagList(
    nowui_card(title = 'Fator de risco',
    reactableOutput(ns('tabela')))
 
  )
}
    
#' table Server Functions
#'
#' @noRd 
mod_table_fator_server <- function(id, data){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    data_ <- data
    output$tabela <- renderReactable({
      data_ <- data_()
      data_ <- with(data_, as.data.frame(table(cod_risco), stringsAsFactors = F))
      data_[,1] <- as.numeric(data_[,1])
      data_ <- left_join(data_, risco[,1:2], by = c('cod_risco'))
      names(data_)[3:2] <- c('Fator de risco', 'Quantidade')
      data_ <- data_[,c(3,2)]
      reactable(data_ , pagination = F, height = '400px')
    })

  })
}
    
## To be copied in the UI
# mod_table_fator_ui("table_fator_1")
    
## To be copied in the server
# mod_table_fator_server("table_fator_1")
