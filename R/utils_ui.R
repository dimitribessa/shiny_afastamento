#' ui functions
#' @import shiny
#' @importFrom htmltools HTML
#' @noRd

nowui_header_resources <- function(title = 'Título'){
     HTML(sprintf(
    '<meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>
  %s
  </title>
  <meta content=\'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no\' name=\'viewport\' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
  <!-- CSS Files -->
  <link href="www/now_ui/assets/css/bootstrap.min.css" rel="stylesheet" /> 
  <link href="www/now_ui/assets/css/now-ui-dashboard.css?v=1.5.0" rel="stylesheet" />
  <!-- <script src = "./JS/input_dropdown.js"></script> -->
  ',title
   ))
 }

#' run all js dependencies (TODO improve it)
nowui_js <- function(){
     HTML('<!--   Core JS Files   -->
 <script src="www/now_ui/assets/js/core/popper.min.js"></script>
  <script src="www/now_ui/assets/js/core/bootstrap.min.js"></script> 
  <script src="www/now_ui/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
 
  <!--  Notifications Plugin    -->
  <script src="www/now_ui/assets/js/plugins/bootstrap-notify.js"></script>
  <!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="www/now_ui/assets/js/now-ui-dashboard.min.js" type="text/javascript"></script>
  <script src="www/now_ui/assets/demo/demo.js"></script>
  '
   )
}

#' functions to build a side bar menu tab
#' 
 nowui_sidebar <- function(..., color = 'orange', logo = NULL){
    tagList(
        tags$div(class = 'sidebar', `data-color` = color,
            logo,
            tags$div(class="sidebar-wrapper", id="sidebar-wrapper",
                tags$ul(class="nav ", role="tablist", id = 'ul',
                ...
                )
            )
             ),
        HTML("<script>
$(function() { // Shorthand for $(document).ready()
    // Target only ul elements inside #myContainer
    $('#ul').on('click', 'li', function() {
        // $(this) = clicked ul
        // .addClass('active') - adds class to clicked ul
        // .siblings('ul') - finds other ul elements at same level
        // .removeClass('active') - removes class from them
        $(this).addClass('active').siblings('li').removeClass('active');
    });
});
</script>")
        
    )

 }

 nowui_navitem <- function(tab, text, active = T, icon = NULL){
   
    tagList(
        tags$li(class = paste('nav-item', if(active){'active'}),
            tags$a(class = 'nav-link',
            id = paste0(tab,'-tab'),
            role ='tab', 
            href = paste0('#',tab), `aria-controls` = tab,
            `aria-selected` = if(active){'true'}else{'false'},
            `data-toggle` = 'pill',
            #tags$a(id = paste0(tab,'-tab'),role ='tab', href = paste0('#',tab),`data-target`  = paste0('#',tab), `aria-controls` = tab, `aria-selected` = if(active){'true'}else{'false'},
            tags$i(class = icon),
            tags$p(text)
            )
        )
    )
 }
 
 nowui_content <- function(...){
    tagList(
        tags$div(class = 'tab-content',
        ...
        )
    )

 }

 nowui_tab <- function(tab,active = T, ...){
    tagList(
        tags$div(id=tab, class = paste('tab-pane fade', if(active){'show active'}),  `aria-labelledby`=paste0(tab,'-tab'),role = 'tabpanel',
                tags$div(class="main-panel ps ps--active-y", id="main-panel",
                ...)
            )
       
    )

 }

 #' navbar
 #'
 nowui_navbar <- function(...,title = 'Título'){
    tagList(
        
        tags$nav(class="navbar navbar-expand-lg navbar-transparent  bg-primary  navbar-absolute",
            tags$div(class = 'container-fluid',
                tags$div(class = 'navbar-wrapper',
                tags$a(class = 'navbar-brand', title)  
                ),
                tags$div( class="collapse navbar-collapse justify-content-end", id="navigation",
                ...
                )
        )
        )
    )
 }

 #' cards
 #' #' only cards elements
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

 #' author card
 
 nowui_card_author <- function(image, photo, title, texto, linkedin, github){
    add_resource_path(
    "www",
    app_sys("app/www")
  )
    tagList(
        tags$div(class = 'card card-user',
        tags$div(class = 'image',
            tags$img(src = image)),
        tags$div(class = 'card-body',
            tags$div(class = 'author',
                tags$a(
                tags$img(class = 'avatar boder-gray', src = photo),
                tags$h5(class = 'title', title)                
                )),
            tags$p(class = 'description center', texto),
            hr(),
            tags$div(class = 'button-container',
                tags$button(
                    href = linkedin, class="btn btn-neutral btn-icon btn-round btn-lg",
                    tags$i(class="fab fa-linkedin")
                )
                ,
                tags$button(
                    href = github, class="btn btn-neutral btn-icon btn-round btn-lg",
                    tags$i(class="fab fa-github")
                )
            )
        ))
    ) #end taglist
 }

 
