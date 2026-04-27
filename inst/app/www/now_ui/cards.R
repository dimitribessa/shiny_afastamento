 #' only cards elements
 #' 
 nowui_card <- function(..., title = NULL, category = NULL, dropdown = NULL){
    category_ <- tags$h5(class = "card-category", category)
    title_ <- tags$h4(class = "card-title", title)
    dropdown_ <- dropdown
    
    if(!is.null(title)  | !is.null(category) | !is.null(dropdown)){
      header <- tags$div(class = 'card-header', 
                category_, title_, dropdown_
            )
    }else{header <- NULL}

    tagList(
      tags$div(class = 'card card-chart',
      header,
      tags$div(class = 'card-body', ...)
      )
    )
 }

 nowui_dropdowncard <- function(x, id = 'id'){

  itens <- paste(sprintf('<a class="dropdown-item" >%s</a>', x), collapse = ' ' )
  id <- id
   HTML(glue::glue('<div class="dropdown  custom-dropdown"  id={id}>
                  <button type="button" class="btn btn-round btn-outline-default dropdown-toggle btn-simple btn-icon no-caret" data-toggle="dropdown">
                    <i class="now-ui-icons loader_gear"></i>
                  </button>
                  <div class="dropdown-menu dropdown-menu-right ">
                    {itens}
                  </div>
                </div>'))
 }
 
