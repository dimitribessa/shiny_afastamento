#' sankey UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' 
#' @importFrom dplyr left_join

mod_sankey_ui <- function(id) {
  ns <- NS(id)
  tagList(
    nowui_card(title = 'Relação entre as variáveis (sankey graph)', category = NULL, 
               echartsOutput(ns('graf_sankey'), height = '500px'))
  )
}
    
#' sankey Server Functions
#'
#' @noRd 
mod_sankey_server <- function(id, data){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    data_ <- data

    output$graf_sankey <- renderEcharts({
      data_ <- data_()
      data_$cod_grupo_risco <- substr(data_$cod_risco,1,1)

      data_1 <- with(data_, as.data.frame(table(tipo.do.acidente, seção), stringsAsFactors = F))
      data_1 <- data_1[data_1$Freq > 0,]
      data_1 <- left_join(data_1, cnae_secao, by = 'seção')
      data_1 <-  data_1[,c(1,4,3)]
      names(data_1) <- c('source', 'target', 'value')

      data_2 <- with(data_, as.data.frame(table(seção,cod_grupo_risco), stringsAsFactors = F))
      data_2 <- data_2[data_2$Freq > 0,]
      data_2$cod_grupo_risco <- as.numeric(data_2$cod_grupo_risco)
      data_2 <- left_join(data_2, cnae_secao, by = 'seção')
      data_2 <- left_join(data_2, risco[!duplicated(risco$cod_grupo_risco),c('cod_grupo_risco','grupo_risco')],  by = 'cod_grupo_risco')
      
      data_2 <-  data_2[,c(4,5,3)]
      names(data_2) <- c('source', 'target', 'value')

      links <- rbind(data_1, data_2)

      nodes <- c(unique(data_1$source), unique(data_1$target),unique(data_2$source), unique(data_2$target) )
      nodes <- nodes[!duplicated(nodes)]

      nodes <- lapply(nodes, \(x){list(name = x)})
      links <- lapply(seq(nrow(links)), function(x){c(links[x,])})

      list(
            series = list(
                type = 'sankey',
                data = nodes,
                links = links,
                 emphasis = list(focus = 'adjacency')
                ,
                lineStyle = list(color = 'gradient', curveness = 0.5)),
            tooltip = list(trigger = 'item', triggerOn = 'mousemove')
        )

    })
 
  })
}
    
## To be copied in the UI
# mod_sankey_ui("sankey_1")
    
## To be copied in the server
# mod_sankey_server("sankey_1")
