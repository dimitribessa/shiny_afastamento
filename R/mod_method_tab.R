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
mod_method_tab_ui <- function(id) {
  ns <- NS(id)
 tagList(
          nowui_navbar(title = 'Dados e métodos'
          )
          ,
          tags$div(class="panel-header panel-header-sm"),
          tags$div(class = 'content',
          fluidRow(
            column(12,
             nowui_card(
              title = 'Sobre os dados',
              p('A "Comunicação de Acidente de Trabaho (CAT) é um serviço do INSS para informar um acidente de trabalho ou de trajeto, bem como uma doença ocupacional. 
              '),
              p('Os dados estão disponíveis no portal de dados abertos do Governo Federal, podendo ser acessadas ', 
              a(href = 'https://dados.gov.br/dados/conjuntos-dados/inss-comunicacao-de-acidente-de-trabalho-cat1', 'aqui'), ' e ', 
              a(href = 'https://dados.gov.br/dados/conjuntos-dados/comunicacoes-de-acidente-de-trabalho-cat-plano-de-dados-abertos-jun-2023-a-jun-2025', 'aqui')),
              p('Para os dados de vínculos empregatícios (utilizados para calcular a incidência) são provenientes da Relação Anual de
Informações Sociais (RAIS)')
              )
          )
          )#end row
          ,
          fluidRow(
            column(12,
             nowui_card(
              title = 'Sobre a metodologia',
              p('Os conceitos de Fator/Grupo de risco, suas relações e o cálculo de incidência foram baseadas no documento 
              "Diagnóstico ACIDENTES DO TRABALHO NO BRASIL - 2019", disponibilizada ', 
              a(href = 'https://www.gov.br/trabalho-e-emprego/pt-br/assuntos/inspecao-do-trabalho/seguranca-e-saude-no-trabalho/acidentes-de-trabalho-informacoes-1/diagnostico-acidentes-do-trabalho-no-brasil-2019.pdf', 'aqui')
              )
              )
          )
          )#end row         
  )
 ) #end taglist
}
    
#' main_tab Server Functions
#'
#' @noRd 
mod_method_tab_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
   
  })
}
    
## To be copied in the UI
# mod_method_tab_ui("main_tab_1")
    
## To be copied in the server
# mod_method_tab_server("main_tab_1")
