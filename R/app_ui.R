#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    tags$body(
      tags$div(class = 'wrapper',
      nowui_sidebar(color = 'orange', 
      logo = HTML('<div class="logo">
        <a href="http://www.creative-tim.com" class="simple-text logo-mini">
          CT
        </a>
        <a href="http://www.creative-tim.com" class="simple-text logo-normal">
          Creative Tim
        </a>
      </div>'),
      nowui_navitem('tab1','Home', icon = "now-ui-icons business_chart-bar-32"),
      nowui_navitem('tab2','Dados/Método', active = F, icon = "now-ui-icons design_app"),
      nowui_navitem('tab3','Autor', active = F, icon = "now-ui-icons education_atom")
      ), #end sidebar
      nowui_content(
        nowui_tab('tab1',active = T, 
        mod_main_tab_ui('main')          
          )
        ,
        nowui_tab('tab2',active = F,
        mod_method_tab_ui('method')          
          )
        ,
        nowui_tab('tab3',active = F,
        mod_about_tab_ui('about')          
          )
      ) #end nowui_content
      ) #end wrapper      
    ,
   nowui_js()
   )

  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
   # favicon(),
   # bundle_resources(
    #  path = app_sys("app/www"),
    #  app_title = "golem.nowui"
    #)
    # Add here other external resources
    #,
    nowui_header_resources()
    
  )
}
