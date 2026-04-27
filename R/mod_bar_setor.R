#' bar_setor UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom dplyr left_join
mod_bar_setor_ui <- function(id) {
  ns <- NS(id)
  tagList(
    nowui_card(title = 'Afastamento por seção CNAE', category = NULL, 
               apexchartOutput(ns('graf_bar')))
  )
}    
#' bar_setor Server Functions
#'
#' @noRd 
mod_bar_setor_server <- function(id, data){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    data_ <- data

    output$graf_bar <- renderApex({
    data_ <- data_()
    data_ <- with(data_,as.data.frame(table(seção), stringsAsFactors  =F))
    data_ <- data_[order(data_$Freq, decreasing = T),]
    data_ <- left_join(data_, cnae_secao, by = 'seção')
    data_ <- data_[,3:2]
    
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
            horizontal = TRUE,
            dataLabels = list(position = 'top')
          )
        )
        ,
        dataLabels = list(enabled = T, style = list(colors = list('#000000')), offsetYX = 20)
            ) 
    }) #end renderApex
 
  })
}
    
## To be copied in the UI
# mod_bar_setor_ui("bar_setor_1")
    
## To be copied in the server
# mod_bar_setor_server("bar_setor_1")
