#' method_tab UI Function
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
mod_about_tab_ui <- function(id) {
  ns <- NS(id)
 tagList(
          tags$div(class="panel-header",
          HTML('<div class="header text-center">
          <h2 class="title">Sobre o autor</h2>
         
        </div>')),
          tags$div(class = 'content',
          tags$div(class = 'row "d-flex justify-content-center',

            column(4,
             nowui_card_author('www/now_ui/assets/img/header.jpg', 'www/now_ui/assets/img/autor-01.jpg', 'Dimitri Bessa', 
             "PhD in economics, but with passion for all kinds of data!", 'https://www.linkedin.com/in/dimitri-bessa-584210136/','https://github.com/dimitribessa')
              )
          
          )#end row
                 
  )
 ) #end taglist
}
    
#' main_tab Server Functions
#'
#' @noRd 
mod_about_tab_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
   
  })
}
    
## To be copied in the UI
# mod_about_tab_ui("main_tab_1")
    
## To be copied in the server
# mod_about_tab_server("main_tab_1")
