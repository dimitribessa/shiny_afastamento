 #' echarts output binding 

 #' @return charts using echart js library
 #' @import htmltools
 #' @import shiny
 #' @export
 


 #usando echarts (30-maio-2023, 16:34h)
 echarts <- function(){
   htmltools::htmlDependency( #ver isso aqui
    name = "echarts",
    version = "5.4.2",
    src = c(href = "https://cdn.jsdelivr.net/npm/echarts@5.4.2/dist"),
    script = "echarts.min.js"
  )}
 
# To be called from ui.R
 echartsOutput <- function(inputId, width="100%", height="100%") { #
 add_resource_path(
    "www",
    app_sys("app/www")
  )
  style <- sprintf("width: %s; height: %s;",
    validateCssUnit(width), validateCssUnit(height))
  
  tagList(
    # Include CSS/JS dependencies. Use "singleton" to make sure that even
    # if multiple lineChartOutputs are used in the same page, we'll still
    # only include these chunks once.
    singleton(tags$head(
      tags$script(src = 'www/js/echarts_general.js')
    )),
    div(id=inputId, class="echarts", style = style,
    #tag("canvas", list())
    ), echarts()
  )
 }
 
 # To be called from server.R
 renderEcharts <- function(expr, env=parent.frame(), quoted=FALSE) {
  # This piece of boilerplate converts the expression `expr` into a
  # function called `func`. It's needed for the RStudio IDE's built-in
  # debugger to work properly on the expression.
  installExprFunction(expr, "func", env, quoted)
  
  function() {
    dataframe <- func()
     dataframe
  }
   
 }
