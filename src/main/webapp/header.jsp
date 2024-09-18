<%@ page import="org.isaagents.ontoapp.QueryFileReader" %>
<%@ page import="org.isaagents.ontoapp.QueryInfo" %>

<%

    ServletContext context = request.getSession().getServletContext();
    QueryInfo queryInfo = (QueryInfo) context.getAttribute("queryInfo");

    if (queryInfo == null) {
        QueryFileReader queryFileReader = new QueryFileReader();
        String jspPath = session.getServletContext().getRealPath("/");
        String queriesFilePath = jspPath + "queries.txt";
        queryInfo = queryFileReader.readFile(queriesFilePath);
        context.setAttribute("queryInfo", queryInfo);
    }

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>STATO: an Ontology of Statistical Methods</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">


    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="assets/css/bootstrap.icon-large.min.css">
    <link rel="stylesheet" href="assets/css/bootstrap.icon-large.css">
    <link rel="stylesheet" href="assets/css/font-awesome.css">
    <link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Lobster' type='text/css'>
    <link href="assets/css/prettyPhoto.css" id="prettyphoto-css" rel="stylesheet" />

    <style>
        a.result:link {color: blue;}
        a.result:visited {color: darkblue;}
        a.result:hover {color: lightblue;}
        a.result:focus {color: darkorange;}
        a.result:active {color: orangered;}


        hr{
            border-top: 1px solid darkorange;
        }


        .carousel {
            height: 600px;
            margin-bottom: 60px;
            vertical-align: middle;
        }
        /* Since positioning the image, we need to help out the caption */
        .carousel-caption {
            z-index: 10;
            margin-top: 0px;
            margin-bottom: 100px;
            height: 400px;
            overflow:scroll;
        }
        /* Declare heights because of positioning of img element */
        .carousel .item {
            width: 100%;
            height: 600px;
            background-color: silver;
        }
        .carousel-inner > .item > img {
            position: absolute;
            top: 0;
            left: 0;
            min-width: 100%;
            height: 500px;
        }

        @media (min-width: 768px) {
            .carousel-caption p {
                margin-top: 10px;
                font-size: 21px;
                line-height: 1.4;
            }
        }

        .flex {
            display: -webkit-box;   /* OLD: Safari,  iOS, Android browser, older WebKit browsers.  */
            display: -moz-box;      /* OLD: Firefox (buggy) */
            display: -ms-flexbox;   /* MID: IE 10 */
            display: -webkit-flex;  /* NEW, Chrome 21+ */
            display: flex;          /* NEW: Opera 12.1, Firefox 22+ */
            -webkit-box-align: center; -moz-box-align: center; /* OLD… */
            -ms-flex-align: center; /* You know the drill now… */
            -webkit-align-items: center;
            align-items: center;
        }


        img {
            background: #EDEFED;
        }

        #carouselButtons {
            margin-left: 100px;
            position: absolute;
            /*bottom: 0px;*/
        }

        /* Spinner - starts */
        .spinner {
            display: inline-block;
            opacity: 0;
            max-width: 0;

            -webkit-transition: opacity 0.25s, max-width 0.45s;
            -moz-transition: opacity 0.25s, max-width 0.45s;
            -o-transition: opacity 0.25s, max-width 0.45s;
            transition: opacity 0.25s, max-width 0.45s; /* Duration fixed since we animate additional hidden width */
        }

        .has-spinner.active {
            cursor:progress;
        }

        .has-spinner.active .spinner {
            opacity: 1;
            max-width: 50px; /* More than it will ever come, notice that this affects on animation duration */
        }
        /* Spinner - ends */


        /** Carousel fade **/

        .carousel.carousel-fade .item {
            -webkit-transition: opacity 2s ease-in-out;
            -moz-transition: opacity 2s ease-in-out;
            -ms-transition: opacity 2s ease-in-out;
            -o-transition: opacity 2s ease-in-out;
            transition: opacity 2s ease-in-out;
        }
        .carousel.carousel-fade .active.left,
        .carousel.carousel-fade .active.right {
            left: 0;
            z-index: 2;
            opacity: 0;
            filter: alpha(opacity=0);
        }
        .carousel.carousel-fade .next,
        .carousel.carousel-fade .prev {
            left: 0;
            z-index: 1;
        }

        .carousel.carousel-fade .carousel-control {
            z-index: 3;
        }
        .unstyled li {
            display: inline;
            vertical-align: baseline;
            padding: 0 16px;
            position: relative;
        }
        /** Carouse fade ends **/

        .popover-title {
            color: darkorange;
            font-size: 15px;
        }
        .popover-content {
            color: #357ebd;
            font-size: 10px;
            text-shadow: none;
            padding: 14px;
            background-color: white;
            -webkit-border-radius: 0 0 3px 3px;
            -moz-border-radius: 0 0 3px 3px;
            border-radius: 0 0 3px 3px;
            -webkit-background-clip: padding-box;
            -moz-background-clip: padding-box;
            background-clip: padding-box;
        }


        .image-circle {
            width: 100px;
            height: 100px;
            border-radius: 150px;
            -webkit-border-radius: 150px;
            -moz-border-radius: 150px;
            background: url(http://link-to-your/image.jpg) no-repeat;
        }


        .highlight {
            color: darkblue;
            font-weight:bold;
        }

        .highlight:hover{
            color: #27AAE1;
        }

        .query-item {
            font-family: "Helvetica";
            float: left;
            width: 250px;
            min-height: 200px;
            margin: 10px;
            border-radius: 3px;
            background-color: #f8f8f8;
            color: #414241;
            padding: 10px;
        }

        .query-item-info {
            height: 150px;
            overflow: hidden;
            border-bottom: 1px solid #ddd;
        }

        .query-name {
            padding-top: 20px;
            font-weight: normal;
            line-height: 15px;
            text-align: center;
            font-size: 1.3em;
            color: #414241;
        }

        .query-item-block {
            height: 80px;
            overflow: hidden;
        }

        .query-item-details {
            color: #aaaaaa;
            text-align: left;
            font-size: 1.1em;
            font-weight: bolder;
            padding: 10px;
            text-align: center;
        }

        .counter {
            float: none;
            padding: 2px 5px;
            font-size: 11px;
            font-weight: bold;
            color: #999;
            background: #eee;
            border-radius: 2px;
        }


        .counter-orange {
            background-color: #eb6b22;
            color: #fff;
            text-shadow: none;
        }


        .btn-group-wrap {
            text-align: center;
        }

        div.btn-group {
            margin: 0 auto;
            text-align: center;
            width: inherit;
            display: inline-block;
        }

        @media screen and (min-width: 768px) {
         .modal .modal-dialog  {width:900px;}
        }

        .github_banner {
            display: block;
            z-index: 10;
            padding: 10px 50px 10px 10px;
            color: #fff;
            background: url('https://raw.githubusercontent.com/GCorbel/blog3/gh-pages/_site/images/blacktocat.png') #f0ad4e no-repeat 95% 50%;
            font-weight: 700;
            box-shadow: 0 0 10px rgba(0,0,0,.5);
            border-bottom-left-radius: 2px;
            border-bottom-right-radius: 2px;
        }

        .banner {
            display: block;
            z-index: 10;
            padding: 10px 50px 10px 10px;
            color: #fff;
            background: #f0ad4e no-repeat 95% 50%;
            font-weight: 700;
            box-shadow: 0 0 10px rgba(0,0,0,.5);
            border-bottom-left-radius: 2px;
            border-bottom-right-radius: 2px;
        }

        .inner {
            position: relative;
            width: 700px;
            padding: 20px 10px;
            margin-left: auto;
            margin-right: auto;
        }


    </style>

    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
    <link rel="shortcut icon" href="../assets/ico/favicon.png">
</head>

<body>
