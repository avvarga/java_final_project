<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %> 
        
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/Modify.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>          
<title>Edit your password</title>
</head>
<body>
<!-- NAV -->
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  	<!-- Brand -->
  	<a class="navbar-brand" href="/">Trading Hub</a>
  	<ul class="navbar-nav">
    	<!-- Dropdown -->
    	<li class="nav-item dropdown">
      		<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        		<c:out value = '${ currentUser.firstName }'/>
      		</a>
      		<div class="dropdown-menu">
        		<a class="dropdown-item" href="#">Settings</a>
        		<a class="dropdown-item" href="/users/${ currentUser.id }/profile">Profile</a>
        		<form id="logoutForm" method="POST" action="/logout">
	        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	        		<input class="dropdown-item" type="submit" value="Logout!" />
	    		</form>
			</div>
		</li>
		<c:choose>
   			<c:when test = "${currentUser.level == 3}">
				<li class="nav-item">
	      		<a class="nav-link" href="/tasks">Tasks</a>
	      		</li>
			</c:when>
			<c:otherwise>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="/tasks" id="navbardrop" data-toggle="dropdown">
	        		Tasks
	      			</a>
	      			<div class="dropdown-menu">
	        			<a class="dropdown-item" href="/tasks/add">Create a new Task</a>
	    				<a class="dropdown-item" href="/tasks">Available Tasks</a>
	      			</div>	
      			</li>
			</c:otherwise>
   		</c:choose>
   		<li class="nav-item">
      		<a class="nav-link" href="/products">Products</a>
    	</li>
    	<li class="nav-item dropdown">
      	<c:choose>
   			<c:when test = "${currentUser.level<3}">
   				<li class="nav-item">
	      			<a class="nav-link" href="/products/add">Add Product</a>
		    	</li>
			</c:when>
   		</c:choose>
   		</li>
  	</ul>
</nav>
<!-- END OF NAV -->
<!-- BODY -->
<div class="container-fluid" style="text-align:center">
	<div class="row justify-content-md-center">
  		<div class="col-3">
  			<h3 style="padding-top: 30px;">Edit your password</h3>
  			
  			
  			<br>
			<form action="/editPassword" method="post" class="form-group">
				<input type="password" name="oldPassword" class="form-control" placeholder="Old Password">
				<p style="color:red"> ${error1}</p>
				<input type="password" name="newPassword" class="form-control" placeholder="New Password">
				<br>
				<input type="password" name="confirmPassword" class="form-control" placeholder="Confirm Password">
				<p style="color:red"> ${error2}</p>
				<p style="color:red"> ${error3}</p>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button id="editButton" class="btn btn-dark">Edit</button>
			</form>
			</div>
	</div>
</div>
</body>
</html>