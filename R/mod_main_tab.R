#' main_tab UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList verbatimTextOutput renderPrint fluidRow column
#' @importFrom dplyr left_join
#' 
mod_main_tab_ui <- function(id) {
  ns <- NS(id)
 tagList(
        
          nowui_navbar(title = 'Comunicação de Acidente de Trabalho (CAT)',
            mod_data_ui(ns('data_cati'))
          )
          ,
          tags$div(class="panel-header panel-header-sm"),
          tags$div(class = 'content',
          fluidRow(class = 'mt-2',
            column(3,
             nowui_card(
              title = textOutput(ns('total')), category = 'Total de afastamentos'
             ))
             ,
             column(3,
             nowui_card(
              title = textOutput(ns('obito')), category = 'Óbitos registrados'
             ))
             ,
             column(3,
             nowui_card(
              title = textOutput(ns('tipico')), category = '% acidentes típicos'
             ))
             ,
             column(3,
             nowui_card(
              title = textOutput(ns('trajeto')), category = '% acidentes no trajeto'
             ))
             
          ), #end row
          fluidRow(
            column(7,
            mod_time_serie_ui(ns('time_serie'))
          )
          ,
          column(5,
            mod_bar_tipo_ui(ns('graf_tipo'))
          )
          )#end row
          ,
          fluidRow(
            column(12,
            mod_bar_setor_ui(ns('graf_setor'))
          )
          )#end row
          ,
          fluidRow(
            column(12,
             mod_sankey_ui(ns("sankey_1"))
          )
          )#end row
          ,
          fluidRow(
            column(6,
             mod_table_ui(ns("tabela1"))
          )
          ,
            column(6,
             mod_table_fator_ui(ns("tabela2"))
          )
          )#end row
         
  )
 ) #end taglist
}
    
#' main_tab Server Functions
#'
#' @noRd 
mod_main_tab_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    dadoi <- mod_data_server('data_cati')
    
    mod_time_serie_server('time_serie', data = dadoi)
    mod_bar_tipo_server('graf_tipo', data = dadoi)
    mod_bar_setor_server('graf_setor', data = dadoi)
    mod_sankey_server('sankey_1', data = dadoi)
   
    mod_table_server('tabela1', data = dadoi)
    mod_table_fator_server('tabela2', data = dadoi)

    #cards
    output$total <- renderText({
      nrow(dadoi())
    })

    output$obito <- renderText({
      data_ <- dadoi()
      nrow(data_[which(data_$indica.óbito.acidente == 'Sim'), ])
    })

    output$tipico <- renderText({
      data_ <- dadoi()
      data_ <- round(nrow(data_[which(data_$tipo.do.acidente == 'Típico'), ])*100/nrow(data_),2)
      paste0(data_,'%')
    })

    output$trajeto <- renderText({
      data_ <- dadoi()
      data_ <- round(nrow(data_[which(data_$tipo.do.acidente == 'Trajeto'), ])*100/nrow(data_),2)
      paste0(data_,'%')
    })
  })
}
    
## To be copied in the UI
# mod_main_tab_ui("main_tab_1")
    
## To be copied in the server
# mod_main_tab_server("main_tab_1")
