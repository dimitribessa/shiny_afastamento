 #---------------------------------------------------------------
 #' now ui dashboard elements
 
  #' dependencies
  #' js
  nowui_js <- function(){
     htmltools::htmlDependency(
  name = "nowui_js",
  version = "1.5.0", 
  src = c(file = 'www/now_ui/assets/js/'),
  script =  list("core/jquery.min.js", 'core/popper.min.js', 'core/bootstrap.min.js', 'plugins/perfect-scrollbar.jquery.min.js',
  'now-ui-dashboard.js')
)
  }

# css
  nowui_css <- function(){
     htmltools::htmlDependency(
  name = "nowui_css",
  version = "1.5.0",
  src = c(file = "www/now_ui/assets/css"), #
  stylesheet = list('now-ui-dashboard.css','bootstrap.min.css')
)}
  
  nowui_icons <- function(){
     htmltools::htmlDependency(
  name = "fontawsome",
  version = "5.7.1",
  src = c(href = "https://use.fontawesome.com/releases/v5.7.1/css/"), # c(href = "https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/"),
  stylesheet = list('all.css') #'font-awesome.min.css'
)}


 #' ---------------------------------------------
 #' head and body
 
 nowui_page <- function( ..., title = 'Title', icon = NULL ){

  head <- tags$head(
     HTML(paste0(
    '<meta charset="utf-8" />
  <link rel="icon" type="image/png" href=',icon,'>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>',
  title, 
    
  '</title>
  <meta content=\'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no\' name=\'viewport\' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
  <!-- CSS Files -->
  <link href="now_ui/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="now_ui/assets/css/now-ui-dashboard.css?v=1.5.0" rel="stylesheet" />
  <script src = "./JS/input_dropdown.js"></script>
  '
   ))
   
  )
   
   body <- tags$body(
    tags$div(class = 'wrapper',
    ...)
    ,
    HTML('<!--   Core JS Files   -->
 <script src="./now_ui/assets/js/core/popper.min.js"></script>
  <script src="./now_ui/assets/js/core/bootstrap.min.js"></script>
  <script src="./now_ui/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
 
  <!--  Notifications Plugin    -->
  <script src="./now_ui/assets/js/plugins/bootstrap-notify.js"></script>
  <!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="./now_ui/assets/js/now-ui-dashboard.min.js" type="text/javascript"></script>
  <script src="./now_ui/assets/demo/demo.js"></script>
  '
   )
   )

   tagList(head, body)
 }


 #' sidebar
  nowui_sidebar <- function(..., color = 'blue', logo = NULL){
          tagList(
            tags$div(class = 'sidebar', `data-color` = color, 
            logo,
            tags$div(class = "sidebar-wrapper ps", id = 'sidebar-wrapper',
              tags$ul(class = 'nav',
                ...)
              )
            )
          )

  }

 #' logo
 nowui_logo <- function(logo){
  tags$div(class = 'logo', logo)
 }
 
 #' TODO bootstrap navpages (04-mar-2026)

 #' main panel
 nowui_mainpanel <- function(..., navbar = NULL, panel = NULL){
      tagList(
        tags$div(class = 'main-panel', id = 'main-panel',
        navbar,
        tags$div(class="panel-header panel-header-sm",
        panel),
        tags$div(class = 'content',
        ...)
        )
          )
 }
 
 #' navbar
 nowui_navbar <- function(title, ...){
    tagList(
      tags$nav(class = "navbar navbar-expand-lg navbar-transparent  bg-primary  navbar-absolute",
        tags$div(class = 'container-fluid',
        tags$div(class = 'navbar-wrapper',
        tags$a(class = 'navbar-brand', href = '#', title)
        )
        ,
        ...
      )
    )
    )
 }

 #' footer
 nowui_footer <- function(...){
  tags$footer(class = 'footer',
    tags$div(class = 'container-fluid',
    ...))
     }