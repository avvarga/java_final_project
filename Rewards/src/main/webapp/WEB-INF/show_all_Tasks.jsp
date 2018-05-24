<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<title>Display of the Tasks</title>
</head>
<body>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="/">Trading Hub</a>
  <ul class="navbar-nav">
    <!-- Dropdown -->
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        Name
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="#">Settings</a>
        <a class="dropdown-item" href="#">Profile</a>
        <form id="logoutForm" method="POST" action="/logout">
	        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	        <input class="dropdown-item" type="submit" value="Logout!" />
	    </form>
     
      </div>
    </li>
    
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        Tasks
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="/tasks/add">Add</a>
        <a class="dropdown-item" href="/tasks">Available Tasks</a>
      </div>
    </li>
  
  <!-- Links -->
    <li class="nav-item">
      <a class="nav-link" href="#">Shop</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">Cart</a>
    </li>
  </ul>
</nav>
<div class="row">
	<div class="col-sm-3">
		<div class="container">
		  <h2>Filters</h2>
		  <ul class="nav flex-column">
		    <li class="nav-item">
		      <a class="nav-link" href="#">All</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" href="#">Level 3</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" href="#">Level 4</a>
		    </li>
		  </ul>
		</div>
	</div>
  	<div class="col-sm-9">
  		<div class="container table-tasks">
		<h2>Tasks Available</h2>
		<br>
			<div class="table-responsive">
			    <table class="table">
			      <thead>
			        <tr>
			          <th>Name</th>
			          <th>Description</th>
			          <th>Worth</th>
			          <th>Status</th>
			          <th>Show</th>
			        </tr>
			      </thead>
			      <tbody>
					<c:forEach items="${ tasks }" var="task">
						<tr>
						<td>${ task.name }</td>
						<td>${ task.description }</td>
						<td>${ task.taskReward.points }</td>
						<td>${ task.status }</td>
						<td><a href="/tasks/${task.id}/show"><button>View Task</button></a></td>
						</tr>
					</c:forEach>
			      </tbody>
				</table>
			</div>
		  </div>	
	</div>
</div>
</body>
</html>