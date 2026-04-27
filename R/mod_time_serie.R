#' time_serie UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom dplyr left_join
mod_time_serie_ui <- function(id) {
  ns <- NS(id)
  tagList(
    nowui_card(title = 'Quantidade de afastamentos', category = NULL, 
              dropdown = tags$div(class = 'dropdown', selectInput(ns('time_choices'), label = NULL, choices = c('Quantidade', 'Incidência'))),
            apexchartOutput(ns('time_serie')))
  )
}    
#' time_serie Server Functions
#'
#' @noRd 
mod_time_serie_server <- function(id, data){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    data_ <- data

    output$time_serie <- renderApex({
    data_ <- data_()

    if(input$time_choices == 'Quantidade'){
      data_ <- as.data.frame(table(data_$data_acidente), stringsAsFactors = F)}
    if(input$time_choices == 'Incidência'){
      incid <- cnae_secao_rais[cnae_secao_rais$ano %in% data_$ano & cnae_secao_rais$cod_cnae %in% data_$seção,]
      incid <- aggregate(quantidade ~ ano, data = incid, FUN = sum)
      data_ <- with(data_,as.data.frame(table(ano), stringsAsFactors = F))
      data_$ano <- as.numeric(data_$ano)
      data_ <- left_join(data_, incid, by = 'ano')
      data_$Freq <- with(data_, round(Freq*1000/quantidade,2))

    }   

    list(series = list(list(name = input$time_choices , data = data_$Freq)),
                            chart = list(type = 'area',
                                         toolbar = c(show = TRUE),
                                         height = 300),
                            
                            xaxis = list(type = 'category',
                                        categories = data_[,1]),
                            legend = list(position = 'bottom'),
                            dataLabels = list(enabled = FALSE),
                             stroke = list(width = 2),
                            fill = list(type = 'gradient',
                                        gradient = list(shadeIntensity = 2,
                                                    inverseColors = F,
                                                    opacityFrom= 0.5,
                                                    opacityTo= 0,
                                                    stops= c(0, 90, 100)))
            )
    }) #end renderApex
 
  })
}
    
## To be copied in the UI
# mod_time_serie_ui("time_serie_1")
    
## To be copied in the server
# mod_time_serie_server("time_serie_1")
