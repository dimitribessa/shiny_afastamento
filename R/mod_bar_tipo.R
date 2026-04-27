#' bar_tipo UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom dplyr left_join
mod_bar_tipo_ui <- function(id) {
  ns <- NS(id)
  tagList(
    nowui_card(title = 'Afastamento por tipo de acidente', category = NULL, 
               apexchartOutput(ns('graf_bar')))
  )
}    
#' bar_tipo Server Functions
#'
#' @noRd 
mod_bar_tipo_server <- function(id, data){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    data_ <- data

    output$graf_bar <- renderApex({
    data_ <- data_()
    data_ <- as.data.frame(table(data_$tipo.do.acidente), stringsAsFactors  =F)
    data_ <- data_[order(data_$Freq, decreasing = T),]

    if(nrow(data_) > 1){
        categoria <- data_[,1]
        dado <- data_$Freq
        }else{
          categoria <- list(data_[,1][1])
          dado <- list(data_$Freq[1])
        }
    
    list(series = list(list(name = 'Quantidade' , data = dado)),
                            chart = list(type = 'bar',
                                         toolbar = c(show = TRUE),
                                         height = 300),
                            
                            xaxis = list(type = 'category',
                                        categories = categoria),
                            plotOptions = list(
          bar = list(
            borderRadius = 4,
            borderRadiusApplication = 'end',
            #horizontal = TRUE,
            dataLabels = list(position = 'top')
          )
        )
        ,
        dataLabels = list(enabled = T, style = list(colors = list('#000000')), offsetY = -20)
            ) 
    }) #end renderApex
 
  })
}
    
## To be copied in the UI
# mod_bar_tipo_ui("bar_tipo_1")
    
## To be copied in the server
# mod_bar_tipo_server("bar_tipo_1")
